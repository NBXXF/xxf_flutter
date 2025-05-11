import 'dart:io';
import 'package:path/path.dart' as p;

/// 泛型扩展 FileSystemEntity（支持 File、Directory、Link）
extension FileSystemEntityPathExtension<T extends FileSystemEntity> on T {
  /// 当前路径的文件名（带扩展名）
  String get basename => p.basename(path);

  /// 当前路径的目录部分
  String get dirname => p.dirname(path);

  /// 文件扩展名（包含点）
  String get extension => p.extension(path);

  /// 不带扩展名的文件名
  String get basenameWithoutExtension => p.basenameWithoutExtension(path);

  /// 拼接当前路径与子路径（返回 T）
  T join(String subPath) {
    final newPath = p.join(path, subPath);
    if (this is Directory) return Directory(newPath) as T;
    if (this is File) return File(newPath) as T;
    if (this is Link) return Link(newPath) as T;

    /// fallback（一般不会触发）
    return File(newPath) as T;
  }

  /// 是否是文件（由路径判断）
  Future<bool> get isFile async => await FileSystemEntity.isFile(path);

  /// 是否是目录（由路径判断）
  Future<bool> get isDirectory async =>
      await FileSystemEntity.isDirectory(path);

  /// 文件大小（仅限 File）
  Future<int> get fileSize async {
    try {
      if (this is File) return await (this as File).length();
    } catch (_) {}
    return 0;
  }
}
