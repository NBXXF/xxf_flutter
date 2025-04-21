import 'package:auto_route/auto_route.dart';

/// ✅ 确保导入生成的 .gr.dart 文件
import 'module_b_router.gr.dart';

// 路由配置类
@AutoRouterConfig()
class ModuleBRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: ModuleBRoute.page, path: "/B/page"),
  ];
}
