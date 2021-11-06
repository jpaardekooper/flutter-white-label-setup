import 'package:base/state/event_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key, required this.function}) : super(key: key);
  final Function function;
  @override
  Widget build(BuildContext context) {
    var evenState = Provider.of<EventState>(context, listen: true);
    return evenState.edit
        ? SizedBox.shrink()
        : BackButton(
            color: Colors.black,
            onPressed: () {
              function();
              Navigator.pop(context);
            },
          );
  }
}
