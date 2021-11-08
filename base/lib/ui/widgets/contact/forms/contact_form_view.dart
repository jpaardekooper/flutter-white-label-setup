import 'package:base/state/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_edit_form.dart';
import 'contact_form.dart';

class ContactFormView extends StatelessWidget {
  const ContactFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);

    return contactState.editProfileToggle ? ContactEditForm() : ContactForm();
  }
}
