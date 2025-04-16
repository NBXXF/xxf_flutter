import 'dart:ui';

import 'package:contextual_menu/contextual_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

typedef ContextMenuBuilder = List<MenuItem> Function(BuildContext context);

/**
 * ContextualMenuArea(
    child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.grey,
    child: Text("ContextualMenuArea"),
    ),
    builder: (context) {
    return [
    MenuItem.submenu(
    label: "复制",
    submenu: Menu(
    items: [
    MenuItem.checkbox(label: "复制全部", checked: false),
    MenuItem.checkbox(label: "复制当前", checked: true),
    ],
    ),
    ),
    MenuItem.separator(),
    MenuItem(label: "粘贴"),
    ];
    },
    )
 */

///桌面端程序之右键菜单
class ContextualMenuArea extends StatefulWidget {
  final Widget child;
  final ContextMenuBuilder builder;

  const ContextualMenuArea({
    super.key,
    required this.child,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() {
    return ContextualMenuAreaState();
  }
}

class ContextualMenuAreaState extends State<ContextualMenuArea> {
  bool _shouldReact = false;
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: widget.child,
      onPointerDown: (details) {
        ///kSecondaryMouseButton	0x02	次键（一般是右键）
        ///PointerDeviceKind.mouse 输入来源是鼠标
        _shouldReact =
            details.kind == PointerDeviceKind.mouse &&
            details.buttons == kSecondaryMouseButton;
      },
      onPointerUp: (details) {
        if (!_shouldReact) return;
        _position = details.position;
        _handleClickPopUp();
      },
    );
  }

  void _handleClickPopUp() {
    popUpContextualMenu(
      Menu(items: widget.builder(context)),
      position: _position,
      placement: Placement.bottomRight,
    );
  }
}
