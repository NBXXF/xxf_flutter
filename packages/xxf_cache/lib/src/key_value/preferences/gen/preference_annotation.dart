class _UserIdentifier {
  const _UserIdentifier();
}
//带上这个注解表示需要加用户标识
const userIdentifier = _UserIdentifier();

class Preference {
  final String? name;

  const Preference({this.name});
}
