// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_demo.dart';

// **************************************************************************
// PreferencesGenerator
// **************************************************************************

//created by xxf<xuanyouwu@gmail.com>, custom preferences
//For more information, please refer to https://pub.dev/packages/xxf_flutter

class _PreferenceDemo extends PreferenceDemo {
  IsarSyncKeyValue? _prefs;

  IsarSyncKeyValue _getPrefs() {
    return _prefs ??= IsarSyncKeyValue();
  }

  @override
  String? get userId {
    final rawKey = 'xxf__userId';
    return _getPrefs().get<String?>(rawKey);
  }

  @override
  set userId(String? value) {
    final rawKey = 'xxf__userId';
    _getPrefs().set(rawKey, value);
  }

  @override
  int get x {
    final rawKey = 'xxf_x';
    return _getPrefs().get<int>(rawKey) ?? 0;
  }

  @override
  set x(int value) {
    final rawKey = 'xxf_x';
    _getPrefs().set(rawKey, value);
  }

  @override
  bool? get isDarkMode {
    final rawKey = 'xxf_isDarkMode_${getUserId() ?? ''}';
    return _getPrefs().get<bool?>(rawKey);
  }

  @override
  set isDarkMode(bool? value) {
    final rawKey = 'xxf_isDarkMode_${getUserId() ?? ''}';
    _getPrefs().set(rawKey, value);
  }

  @override
  DateTime? get lastLoginTime {
    final rawKey = 'xxf_lastLoginTime';
    return DateTimeConverter().convertToEntityProperty(
      _getPrefs().get<String?>(rawKey),
    );
  }

  @override
  set lastLoginTime(DateTime? value) {
    final rawKey = 'xxf_lastLoginTime';
    _getPrefs().set(
      rawKey,
      DateTimeConverter().convertToPreferenceValue(value),
    );
  }
}
