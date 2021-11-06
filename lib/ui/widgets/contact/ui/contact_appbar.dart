import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/components/buttons/event_back_button.dart';
import 'package:base/ui/widgets/components/buttons/toggle_edit_contact.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactAppBar extends StatelessWidget {
  const ContactAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context);

    return AppBar(
      leading: AppBackButton(function: contactState.toggleEditProfile),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: AppbarLogo(),
      centerTitle: true,
      titleSpacing: 0,
      actions: [
        ToggleEditContact(),
      ],
    );
  }
}
