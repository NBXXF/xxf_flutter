import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xxf_extensions/src/editable/editable_text_state_extensions.dart';
import 'package:xxf_extensions/src/editable/text_selection_delegate_extensions.dart';

///编辑区域常用拓展
extension EditableTextStateKeyExtensions on GlobalKey<EditableTextState> {
  ///获取指定焦点区域相对于父容器的坐标系
  Rect? getSelectedBounds({TextSelection? selection}) {
    var mTextSelection = selection;
    mTextSelection ??= textSelection;
    if (mTextSelection != null && mTextSelection.isValid) {
      return currentState?.getSelectedBounds(mTextSelection);
    } else {
      return null;
    }
  }

  /// 获取焦点选择区域所在行的 相对于父容器的坐标系
  Rect? getSelectedLinesBounds({TextSelection? selection}) {
    var mTextSelection = selection;
    mTextSelection ??= textSelection;
    if (mTextSelection != null && mTextSelection.isValid) {
      return currentState?.getSelectedLinesBounds(mTextSelection);
    } else {
      return null;
    }
  }

  ///获取指定焦点区域相对于屏幕坐标系
  Rect? getSelectedBoundsToGlobal(TextSelection selection) {
    return currentState?.getSelectedBoundsToGlobal(selection);
  }

  /// 获取焦点选择区域所在行的 相对于屏幕坐标系
  Rect? getSelectedLinesBoundsToGlobal(TextSelection selection) {
    return currentState?.getSelectedLinesBoundsToGlobal(selection);
  }

  ///请求焦点
  void requestFocus({bool showSelectionOverlay = false}) {
    currentState?.widget.focusNode.requestFocus();
    currentState?.createSelectionOverlayIfNeeded(force: showSelectionOverlay);
    if (showSelectionOverlay) {
      recoverTextSelectionBars();
    }
  }

  ///恢复选区 toolbar 和handle
  void recoverTextSelectionBars() {
    var selection = textSelection ?? const TextSelection.collapsed(offset: -1);
    var hasSelection = selection.isValid && !selection.isCollapsed;
    if (hasSelection) {
      currentState?.showToolbar();
      currentState?.selectionOverlay?.showHandles();
    }
  }

  void requestKeyboard() {
    currentState?.requestKeyboard();
  }

  TextSelection? get textSelection => currentState?.renderEditable.selection;

  ///. renderEditable.selection
  /// 这是 RenderEditable 组件的 selection 属性，表示当前选中的文本范围 (TextSelection)。
  /// 直接修改 renderEditable.selection 只会影响 渲染 层的显示，不会更新 TextEditingController 的 selection 状态，也不会影响逻辑层的 TextEditingValue。
  /// 适用场景：用于自定义 RenderEditable 相关的光标和选区显示，但不会修改 TextEditingValue 的状态。
  ///
  /// 2. currentState?.updateEditingValue(value)
  /// 这个方法是 EditableTextState 的方法，currentState 可能是 EditableText 组件的 State 对象。
  /// updateEditingValue(value) 直接更新 TextEditingValue，不仅改变文本内容，还能同时改变光标位置 (selection)。
  /// 适用场景：当需要同时修改文本内容和光标位置时（例如输入法输入、程序化修改文本）。
  set textSelection(TextSelection? value) {
    /// currentState?.renderEditable.selection = value;
    currentState?.updateEditingValue(
        currentState!.textEditingValue.copyWith(selection: value));
  }

  String getSelectionText() {
    if (textSelection != null && textSelection!.isValid) {
      return textSelection!.textInside(currentState!.text);
    }
    return "";
  }

  ///获取焦点node
  FocusNode? focusNode() {
    return currentState?.widget.focusNode;
  }

  ///请求失焦点
  void unfocus({
    UnfocusDisposition disposition = UnfocusDisposition.scope,
  }) {
    currentState?.widget.focusNode.unfocus();
  }

  void selectAll() {
     currentState?.renderEditable.selection = TextSelection(
      baseOffset: 0,
      extentOffset: currentState?.renderEditable.text?.toPlainText().length??0,
    );
  }
  ///测量文本所占大小
  ///lineMaxWidth 设置为单行宽度,那么高度就有意义
  Size? measureTextWidth(String text,
      {double lineMinWidth = 0.0, double lineMaxWidth = double.infinity}) {
    return currentState?.measureTextWidth(text,
        lineMinWidth: lineMinWidth, lineMaxWidth: lineMaxWidth);
  }

  Size? getRenderEditableSize() {
    return currentState?.getRenderEditableSize();
  }

  double? getPreferredLineHeight() {
    return currentState?.renderEditable.preferredLineHeight;
  }
}
