import 'package:flutter/cupertino.dart';
import 'package:xxf_arch/xxf_arch.dart';

import '../generated/l10n.dart';

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
        Text('text: ${S.of(context).home_account_error}'),
        Text('text2: ${S.current.home_account_error}'),
        GestureDetector(child: Text("切换语言"), onTap: () {

        }),
      ],
    );
  }
}
