import 'dart:async';

import 'impl/isar_shared_preferences.dart' show ISarSharedPreferences;

///键值对存储接口定义
abstract class SharedPreferences {
  static final SharedPreferences _instance = ISarSharedPreferences();

  static SharedPreferences getInstance() {
    return _instance;
  }

  Future<void> putString(String key, String value);

  Future<void> putInt(String key, int value);

  Future<void> putBool(String key, bool value);

  Future<void> putDouble(String key, double value);

  Future<String?> getString(String key);

  Future<int?> getInt(String key);

  Future<bool?> getBool(String key);

  Future<double?> getDouble(String key);

  Future<void> remove(String key);

  Future<void> clear();
}
