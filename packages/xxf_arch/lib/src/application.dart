import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart' show GetIt;

///简化依赖注入
final GetIt getIt = GetIt.instance;

///全局的appRouter,适用于应用级别的页面跳转（如登录页跳转到主页、全局错误页等）。
///区别于context.router(是嵌套场景,自动获取当前最近的StackRouter)
RootStackRouter get rootRouter {
  return getIt.get<RootStackRouter>();
}

/// 设置 appRouter（注册或覆盖）
set rootRouter(RootStackRouter router) {
  if (getIt.isRegistered<RootStackRouter>()) {
    getIt.unregister<RootStackRouter>();
  }
  getIt.registerSingleton<RootStackRouter>(router);
}
