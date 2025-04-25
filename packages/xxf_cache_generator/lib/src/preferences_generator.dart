import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:xxf_cache/xxf_cache.dart';
import 'package:dart_style/dart_style.dart';

const _analyzerIgnores =
    "//created by xxf<xuanyouwu@gmail.com>, custom preferences" +
    "\n//For more information, please refer to https://pub.dev/packages/xxf_flutter";

class PreferencesGenerator extends GeneratorForAnnotation<Preference> {
  static const String _fieldPrefs = "_prefs";
  static const String _funcGetPrefs = "_getPrefs";

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      final name = element.displayName;
      throw InvalidGenerationSourceError(
        'Generator cannot target `$name`.',
        todo: 'Remove the [Preference] annotation from `$name`.',
        element: element,
      );
    }

    return _implementClass(element, annotation);
  }

  String _implementClass(ClassElement element, ConstantReader? annotation) {
    final className = '_${element.name}';
    final preferenceAnnotation = Preference(
      name: annotation?.peek("name")?.stringValue ?? '',
    );
    final annotateClassConsts = element.constructors.where(
      (c) => !c.isFactory && !c.isDefaultConstructor,
    );
    final classBuilder = Class((c) {
      c
        ..name = className
        ..types.addAll(element.typeParameters.map((e) => refer(e.name)))
        ..fields.addAll([_buildPrefsFiled()])
        // ..constructors.addAll(
        //   annotateClassConsts.map(
        //         (e) =>
        //         _generateConstructor(
        //             baseUrl, superClassConst: e, classElement: element),
        //   ),
        // )
        ..methods.addAll([
          _buildGetPrefsFunc(),
          ..._buildFieldGetterAndSetter(
            element,
            annotation,
            preferenceAnnotation,
          ),
        ]);
      c.extend = Reference(element.displayName);
    });

    final emitter = DartEmitter(useNullSafetySyntax: true);
    return DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
    ).format([_analyzerIgnores, classBuilder.accept(emitter)].join('\n\n'));
  }

  ///生成 prefs get方法
  Method _buildGetPrefsFunc() {
    StringBuffer bodyBuilder = StringBuffer();
    bodyBuilder.writeln("return $_fieldPrefs??=$IsarSyncKeyValue();");
    return Method(
      (m) =>
          m
            ..returns = refer("$IsarSyncKeyValue")
            ..name = _funcGetPrefs
            ..body = Code(bodyBuilder.toString()),
    );
  }

  ///生成getter 和setter方法
  List<Method> _buildFieldGetterAndSetter(
    ClassElement element,
    ConstantReader? annotation,
    Preference preference,
  ) {
    List<Method> methodList = [];
    for (var field in element.fields) {
      final String fieldName = field.name;
      final DartType type = field.type;
      final String typeString = type.getDisplayString(withNullability: true);
      if (field.isStatic || field.isConst) {
        continue;
      }

      PreferenceKey preferenceKey = _parsePreferenceKey(field, fieldName);
      if (preferenceKey.diffUser == true &&
          !hasImplementedInterface(element, UserIdProvider)) {
        final todoStr =
            '${element.name} must extends or implements $UserIdProvider';
        throw InvalidGenerationSourceError(
          'Generator cannot target `$fieldName`.$todoStr',
          todo: todoStr,
          element: field,
        );
      }

      var rawKeyValue = preferenceKey.name ?? fieldName;
      if (preference.name != null) {
        rawKeyValue = "${preference.name}_$rawKeyValue";
      }
      if (preferenceKey.diffUser == true) {
        rawKeyValue = "${rawKeyValue}_\${getUserId() ?? ''}";
      }
      final bodyBuilder = StringBuffer();
      final rawKey = "rawKey";
      bodyBuilder.write("final $rawKey = '$rawKeyValue';");

      var parsePreferenceConverterType = _parsePreferenceConverterType(field);
      if (parsePreferenceConverterType != null) {
        ///这里类型是string
        final buildValue = "$_funcGetPrefs().get<String?>($rawKey)";
        bodyBuilder.write(
          "return $parsePreferenceConverterType().convertToEntityProperty($buildValue);",
        );
      } else {
        ///可空类型判断
        if (!isDeclareNullable(type) && preferenceKey.defaultValue == null) {
          final todoStr =
              '$fieldName must add annotation $PreferenceKey add defaultValue';
          throw InvalidGenerationSourceError(
            'Generator cannot target `$fieldName`. $todoStr',
            todo: todoStr,
            element: field,
          );
        }
        final buildValue = "$_funcGetPrefs().get<$typeString>($rawKey)";
        if (preferenceKey.defaultValue != null) {
          bodyBuilder.write(
            "return $buildValue??${formatValue(preferenceKey.defaultValue)};",
          );
        } else {
          bodyBuilder.write("return $buildValue;");
        }
      }

      ///getter
      methodList.add(
        Method(
          (m) =>
              m
                ..annotations.add(CodeExpression(Code('override')))
                ..type = MethodType.getter
                ..returns = refer(typeString)
                ..name = fieldName
                ..body = Code(bodyBuilder.toString()),
        ),
      );

      ///setter
      final valueKey = "value";
      bodyBuilder.clear();
      bodyBuilder.write("final $rawKey = '$rawKeyValue';");
      if (parsePreferenceConverterType != null) {
        bodyBuilder.write(
          "$_funcGetPrefs().set($rawKey,$parsePreferenceConverterType().convertToPreferenceValue($valueKey));",
        );
      } else {
        bodyBuilder.write("$_funcGetPrefs().set($rawKey,$valueKey);");
      }

      methodList.add(
        Method((m) {
          m
            ..annotations.add(CodeExpression(Code('override')))
            ..type = MethodType.setter
            ///..returns = refer('void')
            ..name = fieldName
            ..requiredParameters.add(
              Parameter(
                (p) =>
                    p
                      ..name = valueKey
                      ..type = refer(typeString),
              ),
            )
            ..body = Code(bodyBuilder.toString());
        }),
      );
    }
    return methodList;
  }

  PreferenceKey _parsePreferenceKey(FieldElement field, String fieldName) {
    final checker = TypeChecker.fromRuntime(PreferenceKey);
    final PreferenceKey preferenceKey;
    if (checker.hasAnnotationOf(field)) {
      final annotation = checker.firstAnnotationOf(field);
      final reader = ConstantReader(annotation);
      preferenceKey = PreferenceKey(
        name: reader.peek("name")?.stringValue ?? fieldName,
        diffUser: reader.peek("diffUser")?.boolValue ?? false,
        defaultValue: reader.peek("defaultValue")?.literalValue,
      );
    } else {
      preferenceKey = PreferenceKey(name: fieldName, diffUser: false);
    }
    return preferenceKey;
  }

  ///解析转换器
  String? _parsePreferenceConverterType(FieldElement field) {
    final checker = TypeChecker.fromRuntime(PreferenceConverter);
    if (checker.hasAnnotationOf(field)) {
      final annotation = checker.firstAnnotationOf(field);
      final reader = ConstantReader(annotation);
      final converterType = reader.read('converter').typeValue;
      final converterTypeName = converterType.getDisplayString(
        withNullability: false,
      );
      return converterTypeName;
    }
    return null;
  }

  ///格式化
  String formatValue(Object? object) {
    if (object is String) {
      return literalString(object).accept(DartEmitter()).toString();
    } else {
      return "$object";
    }
  }

  ///是否可空声明
  bool isDeclareNullable(DartType type) {
    return type.nullabilitySuffix == NullabilitySuffix.question;
  }

  Field _buildPrefsFiled() => Field(
    (m) =>
        m
          ..name = _fieldPrefs
          ..type = refer('$IsarSyncKeyValue?')
          ..modifier = FieldModifier.var$,

    ///  ..assignment = Code('$IsarSyncKeyValue()'), // 这里是关键！
  );

  bool hasAnnotation(FieldElement field, Type annotationType) {
    return field.metadata.any((element) {
      final annotation = element.computeConstantValue();
      return annotation?.type?.getDisplayString() == annotationType.toString();
    });
  }

  bool hasImplementedInterface(ClassElement classElement, Type interface) {
    final userInfoChecker = TypeChecker.fromRuntime(interface);
    final isMatch = userInfoChecker.isAssignableFrom(classElement);
    return isMatch;
  }

  String? getDefaultParameterStr(ParameterElement? parameter) {
    if (parameter == null) return null;
    return '${parameter.type.getDisplayString()} ${parameter.name} = ${parameter.defaultValueCode}';
  }
}
