import 'package:auto_route/auto_route.dart';

/// ✅ 确保导入生成的 .gr.dart 文件
import 'module_a_router.gr.dart';

// 路由配置类
@AutoRouterConfig()
class ModuleARouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: ModuleARoute.page, path: "/A/page"),
  ];
}
