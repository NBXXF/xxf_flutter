import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xxf_extensions/src/editable/editable_text_state_extensions.dart';

///编辑区域sectionOverlay拓展
extension EditableTextStateKeySectionOverlayExtensions
    on GlobalKey<EditableTextState> {

  ///更新selectionOverlay 会重新走TextSelectionControls对应的方法
  void selectionOverlayUpdate() {
    currentState?.createSelectionOverlayIfNeeded();
    currentState?.selectionOverlay?.updateForScroll();
  }

}
