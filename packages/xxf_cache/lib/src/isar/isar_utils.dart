import 'dart:io';
import 'package:isar/isar.dart';

///对isar提供安全处理
class IsarUtils {
  IsarUtils._();

  ///同步 获取各个平台兼容的路径
  static Directory getCompatDir({bool ensureCreated = true}) {
    final appFlutterDir = Directory(
      '${Directory.systemTemp.parent.path}${Platform.pathSeparator}app_flutter',
    );
    if (ensureCreated) {
      appFlutterDir.createSync(recursive: true);
    }
    return appFlutterDir;
  }

  static Future<Directory> getCompatDirAsync({
    bool ensureCreated = true,
  }) async {
    final appFlutterDir = getCompatDir(ensureCreated: false);
    if (ensureCreated) {
      await appFlutterDir.create(recursive: true);
    }
    return appFlutterDir;
  }

  static bool verified(Isar? instance) {
    return instance != null && instance.isOpen;
  }

  static Future<Isar> open(
    List<CollectionSchema<dynamic>> schemas, {
    String? directory,
    String name = Isar.defaultName,
    int maxSizeMiB = Isar.defaultMaxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) async {
    var instance = Isar.getInstance(name);
    if (verified(instance)) {
      return instance!;
    } else {
      directory ??= (await getCompatDirAsync(ensureCreated: true)).path;
      return Isar.open(
        schemas,
        directory: directory,
        name: name,
        maxSizeMiB: maxSizeMiB,
        relaxedDurability: relaxedDurability,
        compactOnLaunch: compactOnLaunch,
        inspector: inspector,
      );
    }
  }

  static Isar openSync(
    List<CollectionSchema<dynamic>> schemas, {
    String? directory,
    String name = Isar.defaultName,
    int maxSizeMiB = Isar.defaultMaxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) {
    var instance = Isar.getInstance(name);
    if (verified(instance)) {
      return instance!;
    } else {
      directory ??= getCompatDir(ensureCreated: true).path;
      return Isar.openSync(
        schemas,
        directory: directory,
        name: name,
        maxSizeMiB: maxSizeMiB,
        relaxedDurability: relaxedDurability,
        compactOnLaunch: compactOnLaunch,
        inspector: inspector,
      );
    }
  }
}
