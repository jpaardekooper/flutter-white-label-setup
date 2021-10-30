import 'dart:async';
import 'package:base/page/contact/contact_tabbar.dart';
import 'package:base/page/events/event_screen.dart';
import 'package:base/page/faq/faq_screen.dart';
import 'package:base/page/location/location_page.dart';
import 'package:base/page/twitter/twitter.dart';
import 'package:base/state/location_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/state/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Provider.of<LocationState>(context, listen: false).locationPermission();
    super.initState();
  }

  final List<Widget> currentTab = [
    ContactTabbar(),
    EventScreen(),
    SocialScreen(),
    LocationPage(),
    FaqScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashboardViewModel>(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: currentTab[provider.currentIndex],
          // IndexedStack(
          //     index: provider.currentIndex, children: currentTab),
          bottomNavigationBar: SafeArea(
            child: BottomNavigationBar(
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.setCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.perm_contact_calendar_outlined),
                  label: 'Contacten',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.calendar),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.quick_contacts_mail_outlined),
                  label: 'Social',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_rounded),
                  label: 'Locaties',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_support_outlined),
                  label: 'FAQ',
                ),
              ],
            ),
          ),

          //  NavigationBarTheme(
          //   data: NavigationBarThemeData(
          //     backgroundColor: Colors.white,
          //     labelTextStyle: MaterialStateProperty.all(
          //       TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black,
          //       ),
          //     ),
          //     iconTheme: MaterialStateProperty.all(
          //       IconThemeData(
          //           color: Theme.of(context).colorScheme.secondary),
          //     ),
          //   ),
          //   child: NavigationBar(
          //     height: 65,
          //     selectedIndex: provider.currentIndex,
          //     onDestinationSelected: (index) {
          //       provider.setCurrentIndex(index);
          //     },
          //     destinations: [
          //       NavigationDestination(
          //         icon: Icon(Icons.perm_contact_calendar_outlined),
          //         label: 'Contacten',
          //         selectedIcon: Icon(
          //           Icons.perm_contact_cal_rounded,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.calendar_today_outlined),
          //         label: 'Events',
          //         tooltip: 'Evenementen',
          //         selectedIcon: Icon(
          //           Icons.calendar_today,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.quick_contacts_mail_outlined),
          //         label: 'Social',
          //         selectedIcon: Icon(
          //           Icons.quick_contacts_mail,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.location_on_outlined),
          //         label: 'Locaties',
          //         selectedIcon: Icon(
          //           Icons.location_on,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.contact_support_outlined),
          //         label: 'FAQ',
          //         selectedIcon: Icon(Icons.contact_support,
          //             color: Theme.of(context).colorScheme.primary),
          //       ),
          //     ],
          //   ),
          //            ),
          //          )
        ),
      ),
    );
  }
}
