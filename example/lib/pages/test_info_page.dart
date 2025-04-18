import 'package:flutter/cupertino.dart';
import 'package:xxf_arch/xxf_arch.dart';

@RoutePage()
class TestInfoPage extends StatelessWidget {
  const TestInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Text("back"),
          onTap: () {
            context.router.back();
          },
        ),
        Text("TestPage"),
      ],
    );
  }
}
