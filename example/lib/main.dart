import 'dart:developer' as developer;

import 'package:example/router/app_router.dart' show AppRouter;
import 'package:example/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:module_a/router/module_a_router.gr.dart';
import 'package:module_b/router/module_b_router.gr.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:xxf_log/xxf_log.dart';
import 'package:xxf_resources/xxf_resources.dart';

import 'package:module_a/generated/l10n.dart' as module_a_l10n;
import 'package:module_b/generated/l10n.dart' as module_b_l10n;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptedApp(
      designSize: Size(375, 812), // 设计稿尺寸
      minTextAdapt: true, // 启用文本自适应
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
          darkTheme: ThemeData.light(),
          themeMode: ThemeMode.light,
          // 强制使用 light 主题
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white, // 全局背景色
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
    setState(() {
      _counter++;
    });
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
            const Text('xxf_flutter 技术中台'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(
              child: Text("logger ui"),
              onTap: () {
                context.router.pushNativeRoute(
                  MaterialPageRoute(
                    builder:
                        (context) => LogUtils.config.logger.getLoggerWidget(),
                  ),
                );
              },
            ),
            GestureDetector(
              child: Text("log test"),
              onTap: () {
                context.router.push(LogRoute());
              },
            ),
            GestureDetector(
              child: Text("key_value"),
              onTap: () {
                context.router.push(SharedPreferenceRoute());
              },
            ),
            GestureDetector(
              child: Text("toast"),
              onTap: () {
                final key = "test";
                showToast(key);
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
            GestureDetector(
              child: Text("test"),
              onTap: () {
                context.router.push(TestInfoRoute());
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
