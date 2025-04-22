import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// 全局的 ScaffoldMessengerKey
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();

///默认在底部的snack_bar
/// [content]：SnackBar 显示的内容
/// [backgroundColor]：背景颜色
/// [duration]：显示时长，默认 4 秒
/// [behavior]：显示行为，默认固定在底部
/// [margin]：外边距
/// [padding]：内边距
/// [shape]：形状
/// [action]：可选的操作按钮
/// [onVisible]：SnackBar 显示时的回调
ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSnackBar({
  required Widget content,
  Color? backgroundColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? width,
  ShapeBorder? shape,
  HitTestBehavior? hitTestBehavior,
  SnackBarBehavior? behavior,
  SnackBarAction? action,
  double? actionOverflowThreshold,
  bool? showCloseIcon,
  Color? closeIconColor,
  Duration duration = const Duration(milliseconds: 4000),
  Animation<double>? animation,
  VoidCallback? onVisible,
  DismissDirection? dismissDirection,
  Clip clipBehavior = Clip.hardEdge,
  AnimationStyle? snackBarAnimationStyle,
}) {
  final messengerState = scaffoldMessengerKey.currentState;
  if (messengerState?.mounted ?? false) {
    final snackBar = SnackBar(
      content: content,
      backgroundColor: backgroundColor,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      hitTestBehavior: hitTestBehavior,
      behavior: behavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: showCloseIcon,
      closeIconColor: closeIconColor,
      duration: duration,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection,
      clipBehavior: clipBehavior,
    );

    return messengerState?.showSnackBar(
      snackBar,
      snackBarAnimationStyle: snackBarAnimationStyle,
    );
  }
  return null;
}

///显示顶部的snack_bar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showTopSnackBar({
  required Widget content,
  Color? backgroundColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? width,
  ShapeBorder? shape,
  HitTestBehavior? hitTestBehavior,
  SnackBarBehavior? behavior,
  SnackBarAction? action,
  double? actionOverflowThreshold,
  bool? showCloseIcon,
  Color? closeIconColor,
  Duration duration = const Duration(milliseconds: 4000),
  Animation<double>? animation,
  VoidCallback? onVisible,
  DismissDirection? dismissDirection,
  Clip clipBehavior = Clip.hardEdge,
  AnimationStyle? snackBarAnimationStyle,
}) {
  var firstView = PlatformDispatcher.instance.views.firstOrNull;
  final statusBarHeight =
  firstView != null ? MediaQueryData
      .fromView(firstView)
      .padding
      .top : 0.0;

  ///要在顶部显示 SnackBar，设置 behavior 为 SnackBarBehavior.floating，同时调整 margin 的 top 值。
  showSnackBar(
    behavior: SnackBarBehavior.floating,
    margin: margin,
    content: Stack(
      children: [
        Positioned.fill(
          child: Container(),
        ),
        Align(alignment: Alignment.topCenter, child: content,)
      ],
    ),
    backgroundColor: backgroundColor,
    elevation: elevation,
    padding: padding,
    width: width,
    shape: shape,
    hitTestBehavior: hitTestBehavior,
    action: action,
    actionOverflowThreshold: actionOverflowThreshold,
    showCloseIcon: showCloseIcon,
    closeIconColor: closeIconColor,
    duration: duration,
    animation: animation,
    onVisible: onVisible,
    dismissDirection: dismissDirection,
    clipBehavior: clipBehavior,
    snackBarAnimationStyle: snackBarAnimationStyle,
  );
}
