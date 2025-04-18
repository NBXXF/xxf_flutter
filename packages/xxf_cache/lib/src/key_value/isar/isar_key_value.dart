import 'dart:async';
import 'package:isar/isar.dart';

import 'key_value.dart';

/// 封装了底层的 Isar 数据库，实现了一个键值存储的 API。
class IsarKeyValue {
  IsarKeyValue({this.name = 'default', this.directory = '.'});

  /// 数据库名称
  final String name;

  /// 数据库存储目录
  final String directory;

  /// 延迟初始化的 isar 实例
  late final _isar = Completer<Isar>()..complete(_open());

  /// 打开并初始化 Isar 数据库
  Future<Isar> _open() async {
    final isar = await Isar.open(
      [KeyValueSchema],
      directory: directory,
      name: name,
    );
    return isar;
  }

  /// 关闭底层 isar 数据库实例
  ///
  /// 如果 [deleteDb] 为 true，会同时删除数据库文件
  Future<bool> close({bool deleteDb = false}) async {
    final isar = await _isar.future;
    return isar.close(deleteFromDisk: deleteDb);
  }

  /// 设置 [key] 对应的 [value]
  ///
  /// 如果 [key] 已存在，则会覆盖之前的值
  /// 返回新条目的主键 ID，可用来通过 ID 访问值
  Future<int> set<T>(String key, T value) async {
    final isar = await _isar.future;
    final item = KeyValue()..key = key;
    item.value = value;
    return isar.writeTxn(() => isar.keyValues.put(item));
  }

  /// 获取指定 [key] 的值
  ///
  /// 如果不存在该 [key]，则返回 null
  /// 如果值类型不是 [T]，会抛出类型错误
  Future<T?> get<T>(String key) async {
    final isar = await _isar.future;
    final item = await isar.txn(() => isar.keyValues.getByKey(key));
    return item?.value;
  }

  /// 通过 ID 获取值
  ///
  /// 如果不存在该 ID，则返回 null
  /// 如果值类型不是 [T]，会抛出类型错误
  Future<T?> getById<T>(int id) async {
    final isar = await _isar.future;
    final item = await isar.txn(() => isar.keyValues.get(id));
    return item?.value;
  }

  /// 删除指定 [key] 对应的值
  ///
  /// 删除成功返回 true，失败或 key 不存在返回 false
  Future<bool> remove(String key) async {
    final isar = await _isar.future;
    return isar.writeTxn(() => isar.keyValues.deleteByKey(key));
  }

  /// 删除指定 ID 对应的值
  ///
  /// 删除成功返回 true，失败或 ID 不存在返回 false
  Future<bool> removeById(int id) async {
    final isar = await _isar.future;
    return isar.writeTxn(() => isar.keyValues.delete(id));
  }

  /// 清空所有键值对
  ///
  /// 会清除当前实例及底层数据库中的所有数据
  Future<void> clear() async {
    final isar = await _isar.future;
    return isar.writeTxn(() => isar.clear());
  }
}
