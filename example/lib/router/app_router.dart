import 'package:auto_route/auto_route.dart';
import 'package:example/pages/log_page.dart';
import 'package:module_a/router/module_a_router.dart';
import 'package:module_b/router/module_b_router.dart';

/// ✅ 确保导入生成的 .gr.dart 文件
import 'app_router.gr.dart';

// 路由配置类
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MyHomeRoute.page, // 自动生成的页面路由
      initial: true,
    ),
    AutoRoute(page: TestInfoRoute.page),
    AutoRoute(page: SharedPreferenceRoute.page),
    AutoRoute(page: LogRoute.page),
    ...ModuleARouter().routes,
    ...ModuleBRouter().routes,
  ];

  @override
  List<AutoRouteGuard> get guards => [
    ...ModuleARouter().guards,
    ...ModuleBRouter().guards,
  ];
}
