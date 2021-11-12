import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'boardmember_search.dart';
import 'contact_search.dart';
import 'favorite_search.dart';

class ContactSearchAppBar extends StatelessWidget {
  const ContactSearchAppBar({Key? key}) : super(key: key);

  _showSearchOrLogo(BuildContext context) {
    var contactViewModel = Provider.of<ContactState>(context, listen: true);

    switch (contactViewModel.tabIndex) {
      case 0:
        return contactViewModel.searchToggle ? ContactSearch() : Container();
      case 1:
        return contactViewModel.searchToggle ? FavoriteSearch() : Container();
      case 2:
        return contactViewModel.searchToggle
            ? BoardmemberSearch()
            : Container();
      default:
        return AppbarLogo();
    }
  }

  @override
  Widget build(BuildContext context) {
    var contactViewModel = Provider.of<ContactState>(context, listen: true);

    return AnimatedCrossFade(
      firstChild: AppbarLogo(),
      secondChild: _showSearchOrLogo(context),
      crossFadeState: contactViewModel.searchToggle
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: Duration(milliseconds: 300),
    );
  }
}
