import 'package:base/state/contact_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactBackButton extends StatelessWidget {
  const ContactBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackButton(
      color: Colors.black,
      onPressed: () {
        Provider.of<ContactState>(context, listen: false)
            .fetchDataContactData();
        Navigator.pop(context);
      },
    );
  }
}
