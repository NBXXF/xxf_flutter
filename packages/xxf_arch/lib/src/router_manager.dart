import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart' show GetIt;

import 'get_it_extensions.dart' show getIt;

///全局的appRouter,适用于应用级别的页面跳转（如登录页跳转到主页、全局错误页等）。
///区别于context.router(是嵌套场景,自动获取当前最近的StackRouter)
RootStackRouter get rootRouter {
  return getIt.get<RootStackRouter>();
}

/// 设置 appRouter
set rootRouter(RootStackRouter router) {
  if (getIt.isRegistered<RootStackRouter>()) {
    getIt.unregister<RootStackRouter>();
  }
  initRootRouter(() => router);
}

/// 全局共用一个,一键存在了就不再放入了,业务不应该多次创建router对象
RootStackRouter initRootRouter(RootStackRouter Function() routerBuilder) {
  return getIt.registerSingletonIfAbsent<RootStackRouter>(routerBuilder);
}
