// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:example/main.dart' as _i2;
import 'package:example/pages/log_page.dart' as _i1;
import 'package:example/pages/shared_preference_page.dart' as _i3;
import 'package:example/pages/test_info_page.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i6;

/// generated route for
/// [_i1.LogPage]
class LogRoute extends _i5.PageRouteInfo<void> {
  const LogRoute({List<_i5.PageRouteInfo>? children})
    : super(LogRoute.name, initialChildren: children);

  static const String name = 'LogRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.LogPage();
    },
  );
}

/// generated route for
/// [_i2.MyHomePage]
class MyHomeRoute extends _i5.PageRouteInfo<void> {
  const MyHomeRoute({List<_i5.PageRouteInfo>? children})
    : super(MyHomeRoute.name, initialChildren: children);

  static const String name = 'MyHomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.MyHomePage();
    },
  );
}

/// generated route for
/// [_i3.SharedPreferencePage]
class SharedPreferenceRoute extends _i5.PageRouteInfo<void> {
  const SharedPreferenceRoute({List<_i5.PageRouteInfo>? children})
    : super(SharedPreferenceRoute.name, initialChildren: children);

  static const String name = 'SharedPreferenceRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.SharedPreferencePage();
    },
  );
}

/// generated route for
/// [_i4.TestInfoPage]
class TestInfoRoute extends _i5.PageRouteInfo<TestInfoRouteArgs> {
  TestInfoRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
    : super(
        TestInfoRoute.name,
        args: TestInfoRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'TestInfoRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestInfoRouteArgs>(
        orElse: () => const TestInfoRouteArgs(),
      );
      return _i4.TestInfoPage(key: args.key);
    },
  );
}

class TestInfoRouteArgs {
  const TestInfoRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'TestInfoRouteArgs{key: $key}';
  }
}
