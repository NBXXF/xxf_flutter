import 'package:flutter/cupertino.dart';
import 'package:xxf_arch/xxf_arch.dart';

import '../generated/l10n.dart';

@RoutePage()
class ModuleBPage extends StatelessWidget {
  const ModuleBPage({super.key});

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
        Text('ModuleBPage'),
        Text('text: ${S.of(context).b_test}'),
        Text('text2: ${S.current.b_test}'),
      ],
    );
  }
}
