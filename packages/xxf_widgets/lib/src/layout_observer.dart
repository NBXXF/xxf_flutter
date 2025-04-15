import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

///监听组件的位置或者大小变化
typedef OnWidgetLayoutChange = void Function(
    RenderProxyBox renderBox, LayoutChanges layoutChanges);

///监听子组件的布局,位置和大小
///相比于 [SizeChangedLayoutNotifier] or [HeightObserver] 更全面
class LayoutObserver extends SingleChildRenderObjectWidget {
  const LayoutObserver({
    super.key,
    required this.onLayoutChange,
    this.markNeedsBuild = true,
    required Widget super.child,
  });

  final OnWidgetLayoutChange onLayoutChange;

  ///是否需要重建,那么就会绕过这一帧回调,避免循环锁死
  final bool markNeedsBuild;

  @override
  LayoutObserverRenderObject createRenderObject(BuildContext context) =>
      LayoutObserverRenderObject(onLayoutChange, markNeedsBuild);

  @override
  void updateRenderObject(
    BuildContext context,
    LayoutObserverRenderObject renderObject,
  ) {
    renderObject.onLayoutChange = onLayoutChange;
    renderObject.markNeedsBuild = markNeedsBuild;
  }
}

class LayoutObserverRenderObject extends RenderProxyBox {
  LayoutObserverRenderObject(this.onLayoutChange, this.markNeedsBuild);

  LayoutChanges _oldLayoutChanges =
      LayoutChanges(Offset.zero, Offset.zero, Size.zero, Size.zero);
  OnWidgetLayoutChange? onLayoutChange;
  bool markNeedsBuild = true;

  /// offset是相对于父容器的
  @override
  void paint(PaintingContext context, Offset offset) {
    final Offset globalOffset = localToGlobal(Offset.zero);
    Size newSize = child?.size ?? constraints.smallest;
    _notifyLayoutChangeWithData(globalOffset, newSize);
    super.paint(context, offset);
  }

  @override
  void performLayout() {
    super.performLayout();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!attached) return;

      /// 确保组件仍然存在
      Offset newPosition = child?.localToGlobal(Offset.zero) ?? Offset.zero;
      Size newSize = child?.size ?? constraints.smallest;
      _notifyLayoutChangeWithData(newPosition, newSize);
    });
  }

  void _notifyLayoutChangeWithData(Offset newPosition, Size newSize) {
    LayoutChanges newLayoutChanges =
        _oldLayoutChanges.copy(newPosition: newPosition, newSize: newSize);
    if (newLayoutChanges != _oldLayoutChanges) {
      _oldLayoutChanges = newLayoutChanges.copy();
      if (markNeedsBuild) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _notifyLayoutChange(newLayoutChanges);
        });
      } else {
        _notifyLayoutChange(newLayoutChanges);
      }
    }
  }

  void _notifyLayoutChange(LayoutChanges layoutChanges) {
    if (onLayoutChange != null) {
      onLayoutChange!(this, layoutChanges);
    }
  }
}

class LayoutChanges {
  final Offset oldPosition;
  final Offset newPosition;
  final Size oldSize;
  final Size newSize;

  Rect get oldBounds => oldPosition & oldSize;

  Rect get newBounds => newPosition & newSize;

  LayoutChanges(this.oldPosition, this.newPosition, this.oldSize, this.newSize);

  LayoutChanges copy(
      {Offset? oldPosition,
      Offset? newPosition,
      Size? oldSize,
      Size? newSize}) {
    return LayoutChanges(
        oldPosition ?? this.oldPosition,
        newPosition ?? this.newPosition,
        oldSize ?? this.oldSize,
        newSize ?? this.newSize);
  }

  @override
  bool operator ==(Object other) {
    return other is LayoutChanges &&
        other.oldPosition == oldPosition &&
        other.oldSize == oldSize &&
        other.newPosition == newPosition &&
        other.newSize == newSize;
  }

  @override
  int get hashCode => Object.hash(oldPosition, newPosition, oldSize, newSize);

  @override
  String toString() {
    return 'LayoutChanges{oldPosition: $oldPosition, newPosition: $newPosition, oldSize: $oldSize, newSize: $newSize}';
  }
}
