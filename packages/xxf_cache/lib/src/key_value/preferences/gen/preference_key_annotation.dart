class PreferenceKey {
  ///覆盖key
  final String? name;
  ///是否区分用户
  final bool? diffUser;

  const PreferenceKey({this.name, this.diffUser});
}
