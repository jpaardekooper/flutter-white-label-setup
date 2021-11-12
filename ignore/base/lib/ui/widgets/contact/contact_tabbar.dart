import 'package:base/page/contact/boardmember_overview_page.dart';
import 'package:base/page/contact/contact_overview_page.dart';
import 'package:base/page/contact/favorite_overview_screen.dart';
import 'package:base/state/theme_state.dart';
import 'package:base/ui/widgets/contact/search/contact_search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

class ContactTabbar extends StatefulWidget {
  const ContactTabbar({Key? key}) : super(key: key);

  @override
  State<ContactTabbar> createState() => _ContactTabbarState();
}

class _ContactTabbarState extends State<ContactTabbar> {
  @override
  Widget build(BuildContext context) {
    var contactViewModel = Provider.of<ContactState>(context, listen: true);
    final themeProvider = Provider.of<ThemeProvider>(context);
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
            Switch.adaptive(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                var provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
              },
            ),
            IconButton(
              onPressed: Provider.of<ContactState>(context, listen: false)
                  .toggleSearch,
              icon: Icon(
                contactViewModel.searchToggle ? Icons.close : Icons.search,
                color: Colors.black,
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            onTap: contactViewModel.setTabIndex,
            labelStyle: TextStyle(fontSize: 16),
            tabs: [
              Tab(
                child: const Text(
                  "Contacten",
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ),
              Tab(
                child: const Text(
                  "Favorieten",
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ),
              Tab(
                child: const Text(
                  "Bestuur",
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
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
