import 'package:isar/isar.dart';
///对isar提供安全处理
class IsarUtils {
  IsarUtils._();

  static bool verified(Isar? instance) {
    return instance != null && instance.isOpen;
  }

  static Future<Isar> open(
    List<CollectionSchema<dynamic>> schemas, {
    required String directory,
    String name = Isar.defaultName,
    int maxSizeMiB = Isar.defaultMaxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) {
    var instance = Isar.getInstance(name);
    if (verified(instance)) {
      return Future(() => instance!);
    } else {
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
    required String directory,
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
