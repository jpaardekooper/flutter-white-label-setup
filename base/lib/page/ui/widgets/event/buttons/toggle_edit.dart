import 'package:base/state/app_editing_state.dart';
import 'package:base/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ToggleEditEvent extends StatefulWidget {
  const ToggleEditEvent({Key? key}) : super(key: key);

  @override
  _ToggleEditEventState createState() => _ToggleEditEventState();
}

class _ToggleEditEventState extends State<ToggleEditEvent> {
  @override
  Widget build(BuildContext context) {
    var editingState = Provider.of<AppEditingState>(context);

    var authState =
        Provider.of<AuthState>(context, listen: true).appUser.isAdmin!;

    return authState
        ? IconButton(
            onPressed: () {
              editingState.toggleEdit();
            },
            icon: FaIcon(
              editingState.EditStatus
                  ? Icons.close
                  : FontAwesomeIcons.pencilAlt,
              color: Colors.black,
              size: editingState.EditStatus ? 24 : 18,
            ),
          )
        : SizedBox.shrink();
  }
}
