import 'package:base/state/contact_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactBackButton extends StatelessWidget {
  const ContactBackButton({Key? key, required this.function}) : super(key: key);
  final Function function;
  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return contactState.editProfileToggle
        ? SizedBox.shrink()
        : BackButton(
            color: Colors.black,
            onPressed: () {
              function();
              Navigator.pop(context);
            });
  }
}
