import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///操作toolbar的功能
extension TextSelectionDelegateExtensions on TextSelectionDelegate {
  /// 获取文本
  String get text => textEditingValue.text;

  ///获取选择区间
  TextSelection get selection => textEditingValue.selection;

  ///选择指定区间
  set selection(TextSelection value) {
    setSelectionWithCause(
      value,
      SelectionChangedCause.toolbar,
    );
  }

  ///选择指定区间
  void setSelectionWithCause(TextSelection value, SelectionChangedCause cause) {
    userUpdateTextEditingValue(
      textEditingValue.copyWith(
        selection: value.copyWith(
            baseOffset: value.baseOffset.clamp(-1, text.length),
            extentOffset: value.extentOffset.clamp(-1, text.length)),
      ),
      cause,
    );
  }

  ///是否在段首
  bool _isParagraphStart(String text, int index) {
    if (index == 0) return true; /// 文本开头肯定是段首
    if (index > 0 && text[max(index - 1,0)] == '\n') return true; /// 紧接着换行符
    return false;
  }

  ///查询焦点附近的单词
  TextSelection? findWordRangeAtCursor() {
    try {
      var inputSelection = selection;
      if (inputSelection.isValid && !inputSelection.isCollapsed) {
        return null;
      }

      final cursorOffset = inputSelection.start;
      TextRange wordRange = TextRange.empty;
      if (cursorOffset <= 0) {
        wordRange = _optionSelectTextSelectionWithTextAffinity(
                affinity: TextAffinity.downstream) ??
            TextRange.empty;
        if (isLegal(wordRange, text)) {
          return TextSelection(
              baseOffset: wordRange.start, extentOffset: wordRange.end);
        }
      } else if (cursorOffset >= text.length) {
        wordRange = _optionSelectTextSelectionWithTextAffinity(
                affinity: TextAffinity.upstream) ??
            TextRange.empty;
        if (isLegal(wordRange, text)) {
          return TextSelection(
              baseOffset: wordRange.start, extentOffset: wordRange.end);
        }
      } else {
        wordRange = _optionSelectTextSelectionWithTextAffinity(
                affinity: TextAffinity.downstream) ??
            TextRange.empty;
        if (isLegal(wordRange, text)) {
          return TextSelection(
              baseOffset: wordRange.start, extentOffset: wordRange.end);
        }
        wordRange = _optionSelectTextSelectionWithTextAffinity(
                affinity: TextAffinity.upstream) ??
            TextRange.empty;
        if (isLegal(wordRange, text)) {
          return TextSelection(
              baseOffset: wordRange.start, extentOffset: wordRange.end);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  TextRange? _optionSelectTextSelectionWithTextAffinity(
      {required TextAffinity affinity}) {
    final delegate = this;
    EditableTextState? editableTextState = delegate as EditableTextState?;
    RenderEditable? renderEditable = editableTextState?.renderEditable;
    var inputSelection = delegate.selection;
    String text = delegate.text ?? "";
    if (inputSelection.isValid && !inputSelection.isCollapsed) {
      return null;
    }

    var cursorOffset = inputSelection.start;
    // if (_isParagraphStart(text, cursorOffset)) {
    //   cursorOffset = max(cursorOffset - 1, 0);
    // }
    TextRange wordRange = TextRange.empty;
    wordRange = renderEditable?.getWordAtOffset(
            TextPosition(offset: cursorOffset, affinity: affinity)) ??
        TextRange.empty;
    if (isLegal(wordRange, text)) {
      return wordRange;
    }
    wordRange = renderEditable?.getWordBoundary(
            TextPosition(offset: cursorOffset, affinity: affinity)) ??
        TextRange.empty;
    if (isLegal(wordRange, text)) {
      return wordRange;
    }
    return null;
  }

  bool isLegal(TextRange wordRange, String fullText) {
    if (wordRange.isValid &&
        !wordRange.isCollapsed &&
        wordRange.isNormalized &&
        wordRange.end <= fullText.length) {
      var textInside = wordRange.textInside(fullText);
      if (textInside.isNotNullOrBlank) {
        return true;
      }
    }
    return false;
  }
}
