
///业务请继承或者实现此类,用于自定义类型转换
abstract class PreferencePropertyConverter<T> {
  String? convertToPreferenceValue(T property);

  T convertToEntityProperty(String? databaseValue);
}
