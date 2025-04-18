import 'package:isar/isar.dart';

part 'key_value.g.dart';

@collection
class KeyValue {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  String? stringValue;
  int? intValue;
  double? doubleValue;
  bool? boolValue;
  String? dateTimeValue;
}

extension KeyValueX on KeyValue {
  set value(dynamic value) {
    switch (value.runtimeType) {
      case const (String):
        stringValue = value;
        break;
      case const (int):
        intValue = value;
        break;
      case const (double):
        doubleValue = value;
        break;
      case const (bool):
        boolValue = value;
        break;
      case const (DateTime):
        dateTimeValue = value.toIso8601String();
        break;
      default:
        throw UnsupportedError('${value.runtimeType} is not supported');
    }
  }

  dynamic get value {
    return stringValue ??
        intValue ??
        doubleValue ??
        boolValue ??
        (dateTimeValue != null ? DateTime.parse(dateTimeValue!) : null);
  }
}
