import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:xxf_cache/xxf_cache.dart';
import 'package:xxf_extensions/xxf_extensions.dart';
import 'package:xxf_log/xxf_log.dart';
import 'package:xxf_widgets/xxf_widgets.dart';

import '../preferences/preference_demo.dart';

@RoutePage()
class SharedPreferencePage extends StatelessWidget {
  const SharedPreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          BackButton(),
          Container(
            margin: EdgeInsets.all(20),
            child: DividerColumn(
              divider: SizedBox(height: 20),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  child: Text("key_value 声明式"),
                  onPressed: () {
                    logD(
                      "=============>cached String: ${PreferenceDemo.instance.userId}",
                    );
                    PreferenceDemo.instance.userId = "test ${DateTime.now()}";

                    logD(
                      "=============>cached int: ${PreferenceDemo.instance.x}",
                    );
                    PreferenceDemo.instance.x = PreferenceDemo.instance.x + 1;

                    logD(
                      "=============>cached bool: ${PreferenceDemo.instance.isDarkMode}",
                    );
                    PreferenceDemo.instance.isDarkMode =
                        !(PreferenceDemo.instance.isDarkMode ?? false);

                    logD(
                      "=============>cached customType: ${PreferenceDemo.instance.lastLoginTime}",
                    );
                    PreferenceDemo.instance.lastLoginTime = DateTime.now();
                  },
                ),
                ElevatedButton(
                  child: Text("key_value 原始方式"),
                  onPressed: () {
                    final key = "xxx";
                    SharedPreferences.getInstance().getString(key).then((
                      value,
                    ) {
                      logI(
                        "=========>cached use SharedPreferences: $key =$value",
                      );
                    });
                    SharedPreferences.getInstance().putString(
                      key,
                      "${DateTime.now()}",
                    );
                  },
                ),
                ElevatedButton(
                  child: Text("key_value isar"),
                  onPressed: () {
                    final key = "test";
                    logD(
                      "=============>isarSyncKeyValue set take time:${measureTimeMillis(() {
                        IsarSyncKeyValue().set(key, "${DateTime.now()}");
                      })}",
                    );
                    logD(
                      "=============>isarSyncKeyValue get take time:${measureTimeMillis(() {
                        final value = IsarSyncKeyValue().get(key);
                        logD("=============>isarSyncKeyValue get value:$value");
                      })}",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
