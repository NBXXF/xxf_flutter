import 'package:isar/isar.dart';
import '../../isar/isar_utils.dart';
import 'isar_key_value_config.dart';
import 'key_value.dart';

///同步方式 封装了底层的 Isar 数据库，实现了一个同步风格的键值存储 API。
class IsarSyncKeyValue {
  IsarSyncKeyValue({this.name = dbName, this.directory});

  /// 数据库名称
  final String name;

  /// 数据库存储目录
  final String? directory;

  /// 延迟初始化的 isar 实例
  Isar? _isarInstance;

  /// 获取 isar 实例（延迟初始化）
  Isar get _isar {
    return _isarInstance ??= IsarUtils.openSync(
      [KeyValueSchema],
      name: name,
      directory: directory,
    );
  }

  int set<T>(String key, T value) {
    if (value == null) {
      remove(key);
      return 0;
    }
    final item = KeyValue()..key = key;
    item.value = value;
    return _isar.writeTxnSync(() => _isar.keyValues.putSync(item));
  }

  T? get<T>(String key) {
    final item = _isar.txnSync(() => _isar.keyValues.getByKeySync(key));
    return item?.value;
  }

  T? getById<T>(int id) {
    final item = _isar.txnSync(() => _isar.keyValues.getSync(id));
    return item?.value;
  }

  bool remove(String key) {
    return _isar.writeTxnSync(() => _isar.keyValues.deleteByKeySync(key));
  }

  bool removeById(int id) {
    return _isar.writeTxnSync(() => _isar.keyValues.deleteSync(id));
  }

  void clear() {
    _isar.writeTxnSync(() => _isar.clearSync());
  }

  bool close({bool deleteDb = false}) {
    if (_isarInstance == null) return true;

    /// 尚未初始化就关闭，视为成功
    _isarInstance!.close(deleteFromDisk: deleteDb);
    return true;
  }
}
