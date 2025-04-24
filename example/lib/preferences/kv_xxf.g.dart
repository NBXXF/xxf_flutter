// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kv_xxf.dart';

// **************************************************************************
// KVGenerator
// **************************************************************************

//created by xxf<xuanyouwu@gmail.com>, custom preferences
//For more information, please refer to https://pub.dev/packages/xxf_flutter

class _KvXxf extends KvXxf {
  IsarSyncKeyValue? _prefs;

  IsarSyncKeyValue _getPrefs() {
    if (_prefs != null) return _prefs!;
    final appFlutterDir = Directory(
      '${Directory.systemTemp.parent.path}/app_flutter',
    );
    if (!appFlutterDir.existsSync()) appFlutterDir.createSync();
    return _prefs ??= IsarSyncKeyValue(directory: appFlutterDir.path);
  }

  @override
  String? get userId {
    final rawKey = 'userId';
    return _getPrefs().get<String?>(rawKey);
  }

  @override
  set userId(String? value) {
    final rawKey = 'userId';
    _getPrefs().set(rawKey, value);
  }

  @override
  int? get age {
    final rawKey = '${getUserId() ?? ''}.age';
    return _getPrefs().get<int?>(rawKey);
  }

  @override
  set age(int? value) {
    final rawKey = '${getUserId() ?? ''}.age';
    _getPrefs().set(rawKey, value);
  }

  @override
  double? get size {
    final rawKey = 'size';
    return _getPrefs().get<double?>(rawKey);
  }

  @override
  set size(double? value) {
    final rawKey = 'size';
    _getPrefs().set(rawKey, value);
  }

  @override
  int get x {
    final rawKey = 'x';
    return _getPrefs().get<int>(rawKey);
  }

  @override
  set x(int value) {
    final rawKey = 'x';
    _getPrefs().set(rawKey, value);
  }

  @override
  bool? get isDarkMode {
    final rawKey = 'isDarkMode';
    return _getPrefs().get<bool?>(rawKey);
  }

  @override
  set isDarkMode(bool? value) {
    final rawKey = 'isDarkMode';
    _getPrefs().set(rawKey, value);
  }

  @override
  DateTime? get lastLoginTime {
    final rawKey = 'lastLoginTime';
    return _getPrefs().get<DateTime?>(rawKey);
  }

  @override
  set lastLoginTime(DateTime? value) {
    final rawKey = 'lastLoginTime';
    _getPrefs().set(rawKey, value);
  }
}
