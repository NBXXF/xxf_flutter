import 'dart:core';
import 'package:hashlib/random.dart' show uuid;

@Deprecated("请用randomUUIDString36 或者randomUUIDString32")
String get randomUUIDString {
  return _randomUUIDStringValue;
}

///without dash -
String get randomUUIDString32 {
  return _randomUUIDStringValue;
}

///hash dash -
String get randomUUIDString36 {
  return _randomUUIDStringValue;
}

String get _randomUUIDStringValue {
  return uuid.v4();
}
