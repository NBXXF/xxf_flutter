import 'dart:ui' as ui show Color, Gradient, Image, ImageFilter;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///提供简化
extension GlobalKeyExtensions<T extends State<StatefulWidget>> on GlobalKey<T> {
  RenderObject? get renderObject => currentContext?.findRenderObject();

  RenderBox? get renderBox => currentContext?.findRenderObject() as RenderBox?;

  Offset? get renderOffset => renderBox?.localToGlobal(Offset.zero);

  Size? get renderSize => renderBox?.size;

  Rect? get renderBounds =>
      renderBox != null ? (renderOffset! & renderSize!) : null;

  /// key 对应的组件必须是RepaintBoundary
  /// 发虚 MediaQuery.of(context).devicePixelRatio
  Future<ui.Image> toImage({double pixelRatio = 1.0}) async {
    RenderRepaintBoundary? boundary =
        currentContext?.findRenderObject() as RenderRepaintBoundary?;
    return await boundary!.toImage(pixelRatio: pixelRatio);
  }

  /// key 对应的组件必须是RepaintBoundary
  /// 注意时长
  /// 100 × 100	10,000 px	2 - 5 ms
  /// 500 × 500	250,000 px	10 - 30 ms
  /// 1080 × 1920 (手机全屏)	2,073,600 px	50 - 200 ms
  /// 1440 × 2560 (高分辨率)	3,686,400 px	100 - 500 ms
  ui.Image? toImageSync({double pixelRatio = 1.0}) {
    try {
      RenderRepaintBoundary? boundary =
          currentContext?.findRenderObject() as RenderRepaintBoundary?;
      return boundary!.toImageSync(pixelRatio:pixelRatio);
    } catch (e) {
      return null;
    }
  }
}
