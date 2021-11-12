import 'package:base/models/contact_user.dart';
import 'package:base/page/ui/widgets/contact/tiles/contact_tile.dart';
import 'package:base/page/ui/widgets/text/error_message.dart';
import 'package:base/page/ui/widgets/text/loading_state.dart';

import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

class ContactOverview extends StatefulWidget {
  const ContactOverview({Key? key}) : super(key: key);

  @override
  State<ContactOverview> createState() => _ContactOverviewState();
}

class _ContactOverviewState extends State<ContactOverview>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<ContactState>(context, listen: false).fetchContactData();

    Provider.of<ContactState>(context, listen: false).fetchFavoriteData();

    Provider.of<ContactState>(context, listen: false).fetchBoardmemberData();
  }

  Future<void> _refreshData() async {
    await Provider.of<ContactState>(context, listen: false).fetchContactData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var contactViewModel = Provider.of<ContactState>(context, listen: true);

    return contactViewModel.listOfContacts.isEmpty
        ? contactViewModel.searchToggle
            ? NoDataMessage(message: 'Er is geen overeenkomst gevonden')
            : LoadingState(message: 'Contacten')
        : Scrollbar(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount: contactViewModel.listOfContacts.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  ContactUser contact = contactViewModel.listOfContacts[index];
                  return ContactTiles(contact, 'c');
                },
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
