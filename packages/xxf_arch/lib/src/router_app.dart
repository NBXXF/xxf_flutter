import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xxf_arch/src/router_manager.dart';
import 'package:xxf_lifecycle/xxf_lifecycle.dart';

///创建绑定路由的app
///路由采用auto_route
///生命周期监控采用lifecycle
class RouterApp extends MaterialApp {
  RouterApp.router({
    ///自定义路由相关配置
    required RootStackRouter Function() routerBuilder,
    DeepLinkTransformer? deepLinkTransformer,
    DeepLinkBuilder? deepLinkBuilder,
    String? navRestorationScopeId,
    WidgetBuilder? placeholder,
    NavigatorObserversBuilder navigatorObservers =
        AutoRouterDelegate.defaultNavigatorObserversBuilder,
    bool includePrefixMatches = !kIsWeb,
    bool Function(String? location)? neglectWhen,
    bool rebuildStackOnDeepLink = false,
    Listenable? reevaluateListenable,
    Clip clipBehavior = Clip.hardEdge,

    ///自带属性
    super.key,
    super.scaffoldMessengerKey,
    super.routeInformationProvider,
    super.routeInformationParser,
    super.routerDelegate,
    super.backButtonDispatcher,
    super.builder,
    super.title,
    super.onGenerateTitle,
    super.onNavigationNotification,
    super.color,
    super.theme,
    super.darkTheme,
    super.highContrastTheme,
    super.highContrastDarkTheme,
    super.themeMode = ThemeMode.system,
    super.themeAnimationDuration = kThemeAnimationDuration,
    super.themeAnimationCurve = Curves.linear,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('en', 'US')],
    super.debugShowMaterialGrid = false,
    super.showPerformanceOverlay = false,
    super.checkerboardRasterCacheImages = false,
    super.checkerboardOffscreenLayers = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = true,
    super.shortcuts,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior,
    @Deprecated(
      'Remove this parameter as it is now ignored. '
      'MaterialApp never introduces its own MediaQuery; the View widget takes care of that. '
      'This feature was deprecated after v3.7.0-29.0.pre.',
    )
    super.useInheritedMediaQuery = false,
    super.themeAnimationStyle,
  }) : super.router(
         routerConfig: initRootRouter(routerBuilder).config(
           deepLinkTransformer: deepLinkTransformer,
           deepLinkBuilder: deepLinkBuilder,
           navRestorationScopeId: navRestorationScopeId,
           placeholder: placeholder,
           navigatorObservers: () {
             ///增加默认的生命周期监听defaultLifecycleObserver
             List<NavigatorObserver> list = List.from(navigatorObservers());
             final lifecycleObserver = defaultLifecycleObserver;
             if (!list.contains(lifecycleObserver)) {
               list.insert(0, lifecycleObserver);
             }
             return list;
           },
           includePrefixMatches: includePrefixMatches,
           neglectWhen: neglectWhen,
           rebuildStackOnDeepLink: rebuildStackOnDeepLink,
           reevaluateListenable: reevaluateListenable,
           clipBehavior: clipBehavior,
         ),
       );
}
