import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///编辑区域常用拓展
extension EditableTextStateExtensions on EditableTextState {
  ///获取指定焦点区域相对于父容器的坐标系
  Rect? getSelectedBounds(TextSelection selection) {
    if (!selection.isValid) {
      return null;
    }
    List<TextBox>? list = renderEditable.getBoxesForSelection(selection);

    if (list == null || list.isEmpty) return null;

    double left = list.first.left;
    double top = list.first.top;
    double right = list.first.right;
    double bottom = list.first.bottom;

    for (TextBox box in list) {
      left = min(left, box.left);
      top = min(top, box.top);
      right = max(right, box.right);
      bottom = max(bottom, box.bottom);
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  /// 获取焦点选择区域所在行的 相对于父容器的坐标系
  Rect? getSelectedLinesBounds(TextSelection selection) {
    var rect = getSelectedBounds(selection);
    if (rect != null) {
      return _selectedBoundsToLinesBounds(rect);
    } else {
      return null;
    }
  }

  ///转换成 所在行的区间 选中的第一行取到行头, 选中的最后一行取到行位
  Rect _selectedBoundsToLinesBounds(Rect rect) {
    final lineHeight = renderEditable.preferredLineHeight;
    double top = (rect.top / lineHeight).floor() * lineHeight;
    double bottom = (rect.bottom / lineHeight).ceil() * lineHeight;
    return Rect.fromLTRB(rect.left, top, rect.right, bottom);
  }

  Rect? _boundsToGlobal(Rect selectedBounds) {
    ///RenderBox? renderBox = (widget.key as GlobalKey?)?.renderBox;
    RenderBox? renderBox = context.findAncestorRenderObjectOfType<RenderBox>();
    if (renderBox == null) return null;
    Offset globalTopLeft = renderBox.localToGlobal(selectedBounds.topLeft);
    Offset globalBottomRight =
    renderBox.localToGlobal(selectedBounds.bottomRight);
    return Rect.fromLTRB(
      globalTopLeft.dx,
      globalTopLeft.dy,
      globalBottomRight.dx,
      globalBottomRight.dy,
    );
  }

  ///获取指定焦点区域相对于屏幕坐标系
  Rect? getSelectedBoundsToGlobal(TextSelection selection) {
    var selectedBounds = getSelectedBounds(selection);
    if (selectedBounds == null) return null;
    return _boundsToGlobal(selectedBounds);
  }

  /// 获取焦点选择区域所在行的 相对于屏幕坐标系
  Rect? getSelectedLinesBoundsToGlobal(TextSelection selection) {
    ///切记不要先转换为全局坐标 再来算,（输入框组件可能没有顶到屏幕的开始处）
    var rect = getSelectedLinesBounds(selection);
    if (rect != null) {
      return _boundsToGlobal(rect);
    } else {
      return null;
    }
  }


  ///必须要这样 _createSelectionOverlay创建时机问题
  void createSelectionOverlayIfNeeded({bool force = false}) {
    if (selectionOverlay == null &&
        (force || renderEditable.hasFocus == true)) {
      ///_createSelectionOverlay() 创建时机
      toggleToolbar(false);
    }
  }


  ///测量文本所占大小
  ///lineMaxWidth 设置为单行宽度,那么高度就有意义
  Size measureTextWidth(String text,
      {double lineMinWidth = 0.0, double lineMaxWidth = double.infinity}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: renderEditable.text?.style),
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: lineMinWidth, maxWidth: lineMaxWidth);
    return textPainter.size;
  }

  Size getRenderEditableSize() {
    return renderEditable.size;
  }
}
