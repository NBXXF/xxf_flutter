import 'package:example/router/app_router.dart' show AppRouter;
import 'package:flutter/material.dart';
import 'package:module_a/router/module_a_router.gr.dart';
import 'package:module_b/router/module_b_router.gr.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:xxf_log/xxf_log.dart';
import 'package:xxf_extensions/xxf_extensions.dart';
import 'package:xxf_cache/xxf_cache.dart';
import 'package:xxf_resources/xxf_resources.dart';

import 'package:module_a/generated/l10n.dart' as module_a_l10n;
import 'package:module_b/generated/l10n.dart' as module_b_l10n;
import 'package:intl/src/intl_helpers.dart';
import 'package:intl/message_lookup_by_library.dart';
void main() {
  runApp(MyApp());
}
class MultiCompositeMessageLookup extends CompositeMessageLookup {
@override
void addLocale(String localeName, Function findLocale) {
  logD("==========>localeName:${localeName}");
  final canonical = Intl.canonicalizedLocale(localeName);
  final newLocale = findLocale(canonical);
  if (newLocale != null) {
    final oldLocale = availableMessages[localeName];
    if (oldLocale != null && newLocale != oldLocale) {
      if (newLocale is! MessageLookupByLibrary) {
        throw Exception('Merge locale messages failed, type ${newLocale.runtimeType} is not supported.');
      }
      // solve issue https://github.com/dart-lang/i18n/issues/798 if you are using     intl_translate and intl_util both.
      if (oldLocale.messages is Map<String, Function> && newLocale.messages is! Map<String, Function>) {
        final newMessages = newLocale.messages.map((key, value) => MapEntry(key, value as Function));
        oldLocale.messages.addAll(newMessages);
      } else {
        oldLocale.messages.addAll(newLocale.messages);
      }
      return;
    }
    super.addLocale(localeName, findLocale);
  }
}
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeInternalMessageLookup(() => MultiCompositeMessageLookup());
    return AdaptedApp(
      designSize: Size(375, 812), // 设计稿尺寸
      minTextAdapt: true,  // 启用文本自适应
      builder: (context) {
        return RouterApp.router(
          routerBuilder: () => AppRouter(),
          title: 'Flutter Demo',
          ///希望应用始终使用特定语言（例如英语）
          ///locale: const Locale('en', 'US'),
          locale: const Locale('zh', 'CN'),
          ///加载本地化资源的委托
          ///https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization?utm_source=chatgpt.com
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            module_a_l10n.S.delegate,
            module_b_l10n.S.delegate,
          ],
          ///Flutter 会根据设备的语言设置，在 supportedLocales 中查找匹配的语言环境，并使用相应的本地化资源。如果未找到匹配项，Flutter 将使用列表中的第一个语言环境作为默认值。
          supportedLocales: [
            Locale('en'), // English
            Locale('zh'), // China
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100], // 全局背景色
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
        );
      },
    );
  }
}

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    ///回调方式更加高效,底层逻辑先判断是否打印,再执行回调
    logD(() => "=======>_incrementCounter");
    var measureNano = measureTimeMillis(() {
      logE("=========>count:$_counter");
    });
    logE("=========>take:$measureNano");

    setState(() {
      _counter++;
    });
    test();
  }

  void test() {
    final key = "xxx";
    SharedPreferences.getInstance().getString(key).then((value) {
      logI("=========>cached:$key =$value");
    });
    SharedPreferences.getInstance().putString(key, "$_counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(
              child: Text("logger"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => LogUtils.config.logger.getLoggerWidget(),
                  ),
                );
              },
            ),
            GestureDetector(
              child: Text("router"),
              onTap: () {
                ///context.router.pushPath("/A/page");
                ///context.router.push(ModuleARoute());
                context.router.push(ModuleBRoute());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
