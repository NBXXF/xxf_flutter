

import '../../../../xxf_cache.dart' show SharedPreferences;
import '../../isar/isar_key_value.dart' show IsarKeyValue;

///用isar实现的键值对存储
class ISarSharedPreferences extends SharedPreferences {
  /// 数据库名称
  final String name;

  /// 数据库存储目录
  final String directory;
  final IsarKeyValue _preferences;

  ISarSharedPreferences({this.name = "key_value", this.directory = "."})
    : _preferences = IsarKeyValue(name: name, directory: directory);

  @override
  Future<void> clear() {
    return _preferences.clear();
  }

  @override
  Future<bool?> getBool(String key) {
    return _preferences.get<bool>(key);
  }

  @override
  Future<double?> getDouble(String key) {
    return _preferences.get<double>(key);
  }

  @override
  Future<int?> getInt(String key) {
    return _preferences.get<int>(key);
  }

  @override
  Future<String?> getString(String key) {
    return _preferences.get<String>(key);
  }

  @override
  Future<void> putBool(String key, bool value) {
    return _preferences.set<bool>(key, value).then((_) {});
  }

  @override
  Future<void> putDouble(String key, double value) {
    return _preferences.set<double>(key, value).then((_) {});
  }

  @override
  Future<void> putInt(String key, int value) {
    return _preferences.set<int>(key, value).then((_) {});
  }

  @override
  Future<void> putString(String key, String value) {
    return _preferences.set<String>(key, value).then((_) {});
  }

  @override
  Future<void> remove(String key) {
    return _preferences.remove(key).then((_) {});
  }
}
