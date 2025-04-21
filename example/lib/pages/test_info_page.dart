import 'package:example/http/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:xxf_arch/xxf_arch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class TestInfoPage extends StatelessWidget {
  final counterProvider = StateProvider<int>((ref) => 0);
   TestInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration(seconds: 1));
    return Column(
      children: [
        GestureDetector(
          child: Text("back"),
          onTap: () {
            context.router.back();
          },
        ),
        Text("TestPage"),
        GestureDetector(child: Text("http"),onTap: (){
          ApiClient().getUsers().then((value){

          });
        })
      ],
    );
  }
}
