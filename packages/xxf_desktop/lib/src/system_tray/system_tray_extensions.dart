import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:system_tray/system_tray.dart';

extension SystemTrayExtensions on SystemTray {
  /// iconPath: 系统托盘图标
  /// menus: 点击菜单
  Future<void> initSystemTraySimple({
    required String iconPath,
    String? title,
    String? toolTip,
    bool isTemplate = false,
    List<MenuItemBase>? menus,
  }) async {
    // We first init the systray menu
    await initSystemTray(
      iconPath: iconPath,
      title: title,
      toolTip: toolTip,
      isTemplate: isTemplate,
    );

    if (menus != null && menus.isNotEmpty) {
      // create context menu
      final Menu menu = Menu();
      await menu.buildFrom(menus);
      await setContextMenu(menu);
    }

    // handle system tray event
    registerSystemTrayEventHandler((eventName) {
      debugPrint("=======>eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? appWindow.show() : popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? popUpContextMenu() : appWindow.show();
      }
    });
  }
}
