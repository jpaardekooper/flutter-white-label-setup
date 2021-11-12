import 'package:base/state/app_editing_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_edit_form.dart';
import 'contact_form.dart';

class ContactFormView extends StatelessWidget {
  const ContactFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appEditState = Provider.of<AppEditingState>(context, listen: true);

    return appEditState.EditStatus ? ContactEditForm() : ContactForm();
  }
}
