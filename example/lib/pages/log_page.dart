import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:xxf_extensions/xxf_extensions.dart';
import 'package:xxf_log/xxf_log.dart';

@RoutePage()
class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(),
          ElevatedButton(
            child: Text("http"),
            onPressed: () {
              void measure(String tag, void Function() call) {
                var measureM = measureTimeMicros(call);
                print("========>take（$tag）:$measureM us");
              }

              var dateTime = DateTime.now();
              measure("logD", () {
                logD("=============>test logD:$dateTime", tag: "xx");
              });

              measure("print", () {
                print("=============>test print:$dateTime");
              });

              measure("debugPrint", () {
                debugPrint("=============>test debugPrint:$dateTime");
              });

              measure("developer.log", () {
                developer.log("=============>test developer.log:$dateTime");
              });

              measure("stderr.writeln", () {
                stderr.writeln("=============>test stderr.writeln:$dateTime");
              });
            },
          ),
        ],
      ),
    );
  }
}
