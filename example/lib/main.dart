import 'package:example/router/app_router.dart' show AppRouter;
import 'package:example/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:xxf_log/xxf_log.dart';
import 'package:xxf_extensions/xxf_extensions.dart';
import 'package:xxf_cache/xxf_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    rootRouter=appRouter;
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      )
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
