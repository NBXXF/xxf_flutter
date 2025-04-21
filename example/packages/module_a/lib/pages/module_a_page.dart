import 'package:flutter/cupertino.dart';
import 'package:xxf_arch/xxf_arch.dart';

@RoutePage()
class ModuleAPage extends StatelessWidget {
  const ModuleAPage({super.key});

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
        Text('ModuleAPage'),
      ],
    );
  }
}
