// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:example/main.dart' as _i1;
import 'package:example/pages/test_info_page.dart' as _i2;
import 'package:flutter/cupertino.dart' as _i4;

/// generated route for
/// [_i1.MyHomePage]
class MyHomeRoute extends _i3.PageRouteInfo<void> {
  const MyHomeRoute({List<_i3.PageRouteInfo>? children})
    : super(MyHomeRoute.name, initialChildren: children);

  static const String name = 'MyHomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.MyHomePage();
    },
  );
}

/// generated route for
/// [_i2.TestInfoPage]
class TestInfoRoute extends _i3.PageRouteInfo<TestInfoRouteArgs> {
  TestInfoRoute({_i4.Key? key, List<_i3.PageRouteInfo>? children})
    : super(
        TestInfoRoute.name,
        args: TestInfoRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'TestInfoRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestInfoRouteArgs>(
        orElse: () => const TestInfoRouteArgs(),
      );
      return _i2.TestInfoPage(key: args.key);
    },
  );
}

class TestInfoRouteArgs {
  const TestInfoRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'TestInfoRouteArgs{key: $key}';
  }
}
