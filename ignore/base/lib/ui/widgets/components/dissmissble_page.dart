import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class DissmissibleAppPage extends StatelessWidget {
  const DissmissibleAppPage({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismiss: () => Navigator.of(context).pop(),
      isFullScreen: true,
      dragSensitivity: 1,
      maxTransformValue: 1,
      startingOpacity: 0,
      direction: DismissDirection.horizontal,
      backgroundColor: Colors.transparent,
      child: child,
    );
  }
}
