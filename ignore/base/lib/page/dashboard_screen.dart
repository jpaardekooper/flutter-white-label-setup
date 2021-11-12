import 'dart:async';
import 'dart:io';
import 'package:base/helper/shared_preference.dart';
import 'package:base/page/events/event_screen.dart';
import 'package:base/page/faq/faq_screen.dart';
import 'package:base/page/location/location_page.dart';
import 'package:base/page/twitter/twitter.dart';
import 'package:base/state/auth_state.dart';
import 'package:base/state/location_state.dart';
import 'package:base/ui/widgets/contact/contact_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationState>(context, listen: false).locationPermission();
  }

  late List<Widget> currentTab;

  List loadedPages = [
    0,
  ];

  int _currentIndex = 0;

  void onTapDown() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height, 0, 0),
      items: getMenuItems(),
      color: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  List<PopupMenuEntry<int>> getMenuItems() => [
        PopupMenuItem(
          onTap: () {
            setState(() {
              _currentIndex = 4;
            });
          },
          value: 4,
          textStyle: TextStyle(
              color: _currentIndex == 4
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              fontSize: 14),
          child: Row(
            children: [
              Icon(
                Icons.contact_support_outlined,
                color: _currentIndex == 4
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                width: 10,
              ),
              Text('FAQ')
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              _currentIndex = 4;
            });
          },
          textStyle: TextStyle(
              color: _currentIndex == 5
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              fontSize: 14),
          value: 5,
          child: Row(
            children: [
              Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Instellingen ')
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            _currentIndex = 0;
            Provider.of<LocalStorage>(context, listen: false).clearSession();
            Provider.of<AuthState>(context, listen: false).logout();
          },
          textStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 14),
          value: 6,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Uitloggen ')
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    currentTab = [
      const ContactTabbar(),
      loadedPages.contains(1) ? const EventScreen() : Container(),
      loadedPages.contains(2) ? const SocialScreen() : Container(),
      loadedPages.contains(3) ? const LocationPage() : Container(),
      loadedPages.contains(4) ? const FaqScreen() : Container(),
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.white.withOpacity(0.9)),
      child: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: //currentTab[_currentIndex],
                IndexedStack(index: _currentIndex, children: currentTab),

            bottomNavigationBar: Material(
              elevation: 4,
              child: Container(
                height: Platform.isIOS ? 70 : 55,
                color: Theme.of(context).scaffoldBackgroundColor,
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    selectedItemColor: Theme.of(context).colorScheme.primary,
                    unselectedItemColor:
                        Theme.of(context).colorScheme.secondary,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 20,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      var pages = loadedPages;
                      if (!pages.contains(index)) {
                        pages.add(index);
                      }
                      if (index != 4) {
                        setState(() {
                          _currentIndex = index;
                          loadedPages = pages;
                        });
                      } else {
                        onTapDown();
                      }
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
                        icon: Icon(Icons.more_vert),
                        label: 'Meer',
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
