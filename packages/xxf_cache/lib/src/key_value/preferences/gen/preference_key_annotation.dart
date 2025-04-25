class PreferenceKey {
  ///覆盖key
  final String? name;

  ///是否区分用户
  final bool? diffUser;

  ///默认值
  final Object? defaultValue;

  const PreferenceKey({this.name, this.diffUser, this.defaultValue});
}
