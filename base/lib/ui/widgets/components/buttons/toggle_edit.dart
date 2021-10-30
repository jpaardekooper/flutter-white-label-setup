import 'package:base/state/auth_state.dart';
import 'package:base/state/event_state.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ToggleEditEvent extends StatefulWidget {
  const ToggleEditEvent({Key? key, required this.function}) : super(key: key);

  final Function function;

  @override
  _ToggleEditEventState createState() => _ToggleEditEventState();
}

class _ToggleEditEventState extends State<ToggleEditEvent> {
  @override
  Widget build(BuildContext context) {
    var authState =
        Provider.of<AuthState>(context, listen: true).appUser.isAdmin!;

    var eventState = Provider.of<EventState>(context, listen: true);

    return authState
        ? IconButton(
            onPressed: () {
              widget.function();
            },
            icon: FaIcon(
              eventState.edit ? Icons.close : FontAwesomeIcons.pencilAlt,
              color: Colors.black,
              size: eventState.edit ? 24 : 18,
            ),
          )
        : SizedBox.shrink();
  }
}
