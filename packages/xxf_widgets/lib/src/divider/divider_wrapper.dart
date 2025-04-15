import 'package:flutter/widgets.dart';

class DividerWrapper extends StatelessWidget {
  final Widget child;
  final bool isDivider;

  const DividerWrapper({super.key, required this.child, this.isDivider = false});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}