import 'package:flutter/cupertino.dart';

import 'divider_wrapper.dart' show DividerWrapper;

///支持填充分割线
class DividerColumn extends Column {
  DividerColumn({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    ///如果widget是DividerWrapper 支持动态判断
    required List<Widget> children,
    required Widget divider,
  }) : super(
          children: children.isNotEmpty
              ? (children.expand((widget) {
                  if (widget is DividerWrapper && !widget.isDivider) {
                    return [widget];
                  }
                  return [widget, divider];
                }).toList()
                ..removeLast())
              : <Widget>[],
        );
}


