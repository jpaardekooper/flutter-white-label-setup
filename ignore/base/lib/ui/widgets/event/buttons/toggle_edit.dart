import 'package:base/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ToggleEditEvent extends StatefulWidget {
  const ToggleEditEvent({Key? key, required this.function, required this.edit})
      : super(key: key);
  final bool edit;
  final Function function;

  @override
  _ToggleEditEventState createState() => _ToggleEditEventState();
}

class _ToggleEditEventState extends State<ToggleEditEvent> {
  @override
  Widget build(BuildContext context) {
    var authState =
        Provider.of<AuthState>(context, listen: true).appUser.isAdmin!;

    return authState
        ? IconButton(
            onPressed: () {
              widget.function();
            },
            icon: FaIcon(
              widget.edit ? Icons.close : FontAwesomeIcons.pencilAlt,
              color: Colors.black,
              size: widget.edit ? 24 : 18,
            ),
          )
        : SizedBox.shrink();
  }
}
