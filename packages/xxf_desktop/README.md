<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

桌面端框架

## Features

List what your package can do. Maybe include images, gifs, or videos.

## Getting started

List prerequisites and provide or point to information on how to
start using the package.

## Usage

### 右键菜单
```dart
 ContextualMenuArea(
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
);
```
### 系统托盘
```dart
Future<void> main() async {
  runApp(const MyApp());
  await initSystemTray();
}

Future<void> initSystemTray() async {
  ///图片一定要存在,否则显示不出来
  String path =
  Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.png';

  final SystemTray systemTray = SystemTray();
  await systemTray.initSystemTraySimple(
    title: "file_manager_ai",
    iconPath: path,
    menus: [
      MenuItemLabel(label: 'Show', onClicked: (menuItem) => appWindow.show()),
      MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
      MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
    ],
  );
}

```

## Additional information

Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
