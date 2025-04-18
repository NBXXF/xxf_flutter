import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart' show GetIt;

///简化依赖注入
final GetIt getIt = GetIt.instance;

///全局的appRouter
RootStackRouter get appRouter {
  return getIt.get<RootStackRouter>();
}

/// 设置 appRouter（注册或覆盖）
set appRouter(RootStackRouter router) {
  if (getIt.isRegistered<RootStackRouter>()) {
    getIt.unregister<RootStackRouter>();
  }
  getIt.registerSingleton<RootStackRouter>(router);
}
