import 'package:base/ui/widgets/contact/search/contact_search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

import 'boardmember_overview_page.dart';
import 'contact_overview_page.dart';
import 'favorite_overview_screen.dart';

class ContactTabbar extends StatefulWidget {
  const ContactTabbar({Key? key}) : super(key: key);

  @override
  State<ContactTabbar> createState() => _ContactTabbarState();
}

class _ContactTabbarState extends State<ContactTabbar> {
  @override
  Widget build(BuildContext context) {
    var contactViewModel = Provider.of<ContactState>(context, listen: true);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ContactSearchAppBar(),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: Provider.of<ContactState>(context, listen: false)
                  .toggleSearch,
              icon: Icon(
                contactViewModel.searchToggle ? Icons.close : Icons.search,
                color: Colors.black,
              ),
            ),
            // IconButton(
            //     onPressed: () {
            //       contactViewModel.test.disconnect();
            //     },
            //     icon: Icon(Icons.offline_bolt_rounded))
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            onTap: contactViewModel.setTabIndex,
            tabs: [
              Tab(
                text: 'Contacten',
              ),
              Tab(
                text: 'Favorieten',
              ),
              Tab(
                text: 'Bestuur',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TabBarView(
            children: [
              ContactOverview(),
              FavoriteOverview(),
              BoardMemberOverview()
            ],
          ),
        ),
      ),
    );
  }
}
