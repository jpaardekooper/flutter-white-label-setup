import 'package:base/helper/shared_preference.dart';
import 'package:base/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'input_decoration.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({Key? key}) : super(key: key);

  @override
  _UsernameTextFieldState createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  late TextEditingController usernameController;

  late FocusNode usernameNode;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    usernameNode = FocusNode();

    loadUsername();
  }

  loadUsername() async {
    usernameController.text =
        await Provider.of<LocalStorage>(context, listen: false).getEmail() ??
            '';
  }

  @override
  void dispose() {
    usernameController.dispose();
    usernameNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      controller: usernameController,
      focusNode: usernameNode,
      textInputAction: TextInputAction.next,
      onSaved: (value) =>
          Provider.of<AuthState>(context, listen: false).setUsername(value!),
      onTap: () {
        usernameNode.requestFocus();
      },
      onFieldSubmitted: (term) {
        usernameNode.unfocus();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: inputDecoration(
        usernameNode,
        'Gebruikersnaam',
        Icon(
          Icons.person,
          color: usernameNode.hasFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
        context,
      ),
      validator: (String? value) {
        String? _msg;
        RegExp regex = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
        if (value!.isEmpty) {
          _msg = "Vul je gebruikers naam in";
        } else if (!regex.hasMatch(value)) {
          _msg = "Geef een geldig e-mailadres op";
        }
        return _msg;
      },
    );
  }
}
