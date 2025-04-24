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

class KVGenerator extends GeneratorForAnnotation<Preference> {
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
      );
    }

    return _implementClass(element, annotation);
    final nameSpace = annotation.peek('nameSpace')?.stringValue;
    final prefix = nameSpace != null ? '$nameSpace.' : '';

    final implementsUserIdProvider = hasImplementedInterface(
      element,
      UserIdProvider,
    );

    final className = element.name;
    final implClass = '_${className}Impl';
    final buffer = StringBuffer();

    buffer.writeln('$className ${toLowerCaseFirst(className)} = $implClass();');
    buffer.writeln();
    buffer.writeln('class $implClass extends $className {');

    buffer.writeln();
    buffer.writeln('static $implClass? _instance;');
    buffer.writeln('final IsarSyncKeyValue prefs;');
    buffer.writeln();
    buffer.writeln('$implClass._internal(this.prefs);');
    buffer.writeln();
    buffer.writeln('factory $implClass() {');
    buffer.writeln(
      'final appFlutterDir = Directory(\'\${Directory.systemTemp.parent.path}/app_flutter\');',
    );
    buffer.writeln(
      'if (!appFlutterDir.existsSync()) appFlutterDir.createSync();',
    );
    buffer.writeln(
      '_instance ??= $implClass._internal(IsarSyncKeyValue(directory: appFlutterDir.path));',
    );
    buffer.writeln('return _instance!;');
    buffer.writeln('}');

    for (final field in element.fields) {
      final hasUserIdentifier = hasAnnotation(
        field,
        userIdentifier.runtimeType,
      );

      final fieldName = field.name;

      final fieldType = field.type.getDisplayString();
      final isNullable =
          field.type.nullabilitySuffix == NullabilitySuffix.question;

      // 生成 getter
      buffer.writeln("@override");
      buffer.writeln("$fieldType get $fieldName {");
      if (implementsUserIdProvider && hasUserIdentifier) {
        buffer.writeln(
          "final fieldKey = '\${getUserId() ?? ''}.$prefix$fieldName';",
        );
      } else {
        buffer.writeln("final fieldKey = '$prefix$fieldName';");
      }
      buffer.writeln("return prefs.get<$fieldType>(fieldKey);");
      buffer.writeln("}");

      // 生成 setter
      buffer.writeln("@override");
      buffer.writeln("set $fieldName($fieldType value) {");

      if (implementsUserIdProvider && hasUserIdentifier) {
        buffer.writeln(
          "final fieldKey = '\${getUserId() ?? ''}.$prefix$fieldName';",
        );
      } else {
        buffer.writeln("final fieldKey = '$prefix$fieldName';");
      }

      if (isNullable) {
        buffer.writeln("if (value == null) {");
        buffer.writeln("prefs.remove(fieldKey);");
        buffer.writeln("} else {");
        buffer.writeln("prefs.set(fieldKey, value);");
        buffer.writeln("}");
      } else {
        buffer.writeln("prefs.set(fieldKey, value);");
      }
      buffer.writeln("}");
    }

    buffer.writeln('}');
    return buffer.toString();
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
        ..methods.addAll([_buildGetPrefsFunc(),..._buildFieldGetterAndSetter(element, annotation)]);
      c.extend = Reference(element.displayName);
    });

    final emitter = DartEmitter(useNullSafetySyntax: true);
    return DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
    ).format([_analyzerIgnores, classBuilder.accept(emitter)].join('\n\n'));
  }

  ///生成 prefs get方法
  Method _buildGetPrefsFunc() {
    StringBuffer bodyBuilder=StringBuffer();
    bodyBuilder.writeln("if ($_fieldPrefs!=null) return $_fieldPrefs!;");
    bodyBuilder.writeln("final appFlutterDir =Directory('\${Directory.systemTemp.parent.path}/app_flutter');");
    bodyBuilder.writeln("if (!appFlutterDir.existsSync()) appFlutterDir.createSync();");
    bodyBuilder.writeln("return $_fieldPrefs??=$IsarSyncKeyValue(directory: appFlutterDir.path);");
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
  ) {
    List<Method> methodList = [];
    for (var field in element.fields) {
      final String fieldName = field.name;
      final DartType type = field.type;
      final String typeString = type.getDisplayString(withNullability: true);
      if (field.isStatic || field.isConst) {
        continue;
      }

      final checker = TypeChecker.fromRuntime(PreferenceKey);
      final PreferenceKey preferenceKey;
      if (checker.hasAnnotationOf(field)) {
        final annotation = checker.firstAnnotationOf(field);
        final reader = ConstantReader(annotation);
        preferenceKey = PreferenceKey(
          name: reader.peek("name")?.stringValue ?? fieldName,
          diffUser: reader.peek("diffUser")?.boolValue ?? false,
        );
      } else {
        preferenceKey = PreferenceKey(name: fieldName, diffUser: false);
      }
      if (preferenceKey.diffUser == true &&
          !hasImplementedInterface(element, UserIdProvider)) {
        throw InvalidGenerationSourceError(
          'Generator cannot target `$fieldName`.',
          todo: '${element.name} must extends or implements $UserIdProvider',
        );
      }

      var rawKeyValue = "'${preferenceKey.name ?? fieldName}'";
      if (preferenceKey.diffUser == true) {
        rawKeyValue = "'\${getUserId() ?? ''}.$fieldName'";
      }
      final bodyBuilder = StringBuffer();
      final rawKey = "rawKey";
      bodyBuilder.write("final $rawKey = $rawKeyValue;");
      bodyBuilder.write("return $_funcGetPrefs().get<$typeString>($rawKey);");

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
      bodyBuilder.write("final $rawKey = $rawKeyValue;");
      bodyBuilder.write("$_funcGetPrefs().set($rawKey,$valueKey);");

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

  Field _buildPrefsFiled() => Field(
    (m) =>
        m
          ..name = _fieldPrefs
          ..type = refer('$IsarSyncKeyValue?')
          ..modifier = FieldModifier.var$
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

  String _toSetMethod(String type) {
    return _toGetMethod(type);
  }

  String _toGetMethod(String type) {
    switch (type) {
      case 'String':
      case 'String?':
        return 'String';
      case 'int':
      case 'int?':
        return 'Int';
      case 'bool':
      case 'bool?':
        return 'Bool';
      case 'double':
      case 'double?':
        return 'Double';
      case 'List<String>':
      case 'List<String>?':
        return 'StringList';
      default:
        throw UnsupportedError('Unsupported return type: $type');
    }
  }
}

String toLowerCaseFirst(String input) {
  if (input.isEmpty) return input;
  return input[0].toLowerCase() + input.substring(1);
}
