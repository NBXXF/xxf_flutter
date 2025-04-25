import 'package:example/http/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xxf_log/xxf_log.dart';

@RoutePage()
class TestInfoPage extends HookConsumerWidget {
  final counterProvider = StateProvider<int>((ref) => 0);

  TestInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(counterProvider);
    final animationController = useAnimationController(
      duration: Duration(seconds: 1),
    );
    return Column(
      children: [
        BackButton(),
        Text("TestPage ${count}"),
        GestureDetector(
          child: Text("http"),
          onTap: () {
            ref.read(counterProvider.notifier).state++;
            ApiClient().getUsers2().listen((data) {
              logD("=============>$data");
            });
          },
        ),
      ],
    );
  }
}
