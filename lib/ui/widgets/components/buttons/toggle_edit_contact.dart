import 'package:base/state/auth_state.dart';
import 'package:base/state/contact_state.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ToggleEditContact extends StatefulWidget {
  const ToggleEditContact({Key? key, required this.function}) : super(key: key);
  final Function function;

  @override
  _ToggleEditContactState createState() => _ToggleEditContactState();
}

class _ToggleEditContactState extends State<ToggleEditContact> {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context, listen: false);

    var contactState = Provider.of<ContactState>(context, listen: true);
    return authState.appUser.isAdmin! ||
            contactState.selectedContactUser.id == authState.appUser.id
        ? IconButton(
            onPressed: () {
              widget.function();
            },
            icon: FaIcon(
              contactState.editProfileToggle
                  ? Icons.close
                  : FontAwesomeIcons.pencilAlt,
              color: Colors.black,
              size: contactState.editProfileToggle ? 24 : 18,
            ),
          )
        : SizedBox.shrink();
  }
}
