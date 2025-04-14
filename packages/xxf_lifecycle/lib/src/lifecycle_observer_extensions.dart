import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';

///堆栈
@Deprecated("please use routeStack")
List<Route<dynamic>> get rootStack {
  return defaultLifecycleObserver.rootStack;
}

///堆栈
List<Route<dynamic>> get routeStack {
  return defaultLifecycleObserver.routeStack;
}

///栈顶route
Route<dynamic>? get topRoute {
  return defaultLifecycleObserver.topRoute;
}

///根Route
Route? get rootRoute {
  return defaultLifecycleObserver.rootRoute;
}

///路由栈工具
extension LifecycleObserverExtensions on LifecycleObserver {
  ///堆栈
  List<Route<dynamic>> get routeStack {
    List<Route> mRouteList = [];
    iterateRoutes((Route<dynamic> route) {
      mRouteList.add(route);
      return false;
    });
    return mRouteList;
  }

  ///堆栈
  @Deprecated("please use routeStack")
  List<Route<dynamic>> get rootStack {
    return routeStack;
  }

  ///栈顶route
  Route<dynamic>? get topRoute {
    return rootStack.lastOrNull;
  }

  ///根Route
  Route<dynamic>? get rootRoute {
    return rootStack.firstOrNull;
  }
}
