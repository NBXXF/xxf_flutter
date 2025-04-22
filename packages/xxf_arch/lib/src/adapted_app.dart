import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xxf_arch/src/router_app.dart';

typedef ApplicationBuilder = RouterApp Function(BuildContext context);

///屏幕适配
///内部先植入flutter_screenutil
///river_pod初始化
class AdaptedApp extends ScreenUtilInit {
  AdaptedApp({
    super.key,
    required ApplicationBuilder builder,
    super.rebuildFactor = RebuildFactors.size,
    super.designSize = ScreenUtil.defaultSize,
    super.splitScreenMode = false,
    super.minTextAdapt = false,
    super.useInheritedMediaQuery = false,
    super.ensureScreenSize = false,
    super.enableScaleWH,
    super.enableScaleText,
    super.responsiveWidgets,
    super.excludeWidgets,
    super.fontSizeResolver = FontSizeResolvers.width,
  }) : super(
         builder:
             (BuildContext context, Widget? child) => ProviderScope(
               /// river_pod 的作用域容器
               child: builder(context),
             ),
       );
}
