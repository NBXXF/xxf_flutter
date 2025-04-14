class BaseDecoder {
  static Error createParseError(String expectedType, dynamic value) {
    return ArgumentError(
        'Expected $expectedType but was ${value.runtimeType} for value: $value');
  }
}
