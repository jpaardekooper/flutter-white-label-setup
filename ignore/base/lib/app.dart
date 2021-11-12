import 'package:base/helper/shared_preference.dart';
import 'package:base/page/dashboard_screen.dart';
import 'package:base/page/init_page.dart';
import 'package:base/page/login_screen.dart';
import 'package:base/state/auth_state.dart';
import 'package:base/state/contact_state.dart';
import 'package:base/state/event_state.dart';
import 'package:base/state/faq_view_model.dart';
import 'package:base/state/location_state.dart';
import 'package:base/state/social_state.dart';
import 'package:base/state/theme_state.dart';
import 'package:config/flavor_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseApp extends StatelessWidget {
  final SharedPreferences? sharedPreferences;

  BaseApp({this.sharedPreferences}) : assert(sharedPreferences != null);

  @override
  Widget build(BuildContext context) {
    // Future<User> getUserData() => LocalStorage(sharedPreferences!).getUser();

    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider(create: (_) => LocalStorage(sharedPreferences!)),
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          var localStorage = Provider.of<LocalStorage>(_, listen: false);
          return AuthState(localStorage);
        }),
        // ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider<ContactState>(create: (_) {
          var localStorage = Provider.of<LocalStorage>(_, listen: false);
          var authState = Provider.of<AuthState>(_, listen: false);
          return ContactState(localStorage, authState);
        }),
        ChangeNotifierProvider<EventState>(create: (_) {
          var localStorage = Provider.of<LocalStorage>(_, listen: false);
          var authState = Provider.of<AuthState>(_, listen: false);
          return EventState(localStorage, authState);
        }),
        ChangeNotifierProvider<SocialState>(create: (_) {
          var localStorage = Provider.of<LocalStorage>(_, listen: false);
          return SocialState(localStorage);
        }),
        ChangeNotifierProvider<LocationState>(create: (_) {
          var localStorage = Provider.of<LocalStorage>(_, listen: false);
          var authState = Provider.of<AuthState>(_, listen: false);
          return LocationState(localStorage, authState);
        }),
        ChangeNotifierProvider<FAQState>(create: (_) {
          var localStorage = Provider.of<LocalStorage>(_, listen: false);
          var authState = Provider.of<AuthState>(_, listen: false);
          return FAQState(localStorage, authState);
        }),
      ],
      builder: (context, _) {
        var themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: true,
          themeMode: themeProvider.themeMode,
          theme: FlavorTheme.lightTheme,
          darkTheme: FlavorTheme.darkTheme,
          home: _showScreen(context),
        );
      },
    );
  }

  Widget _showScreen(BuildContext context) {
    switch (context.watch<AuthState>().appState) {
      case AppState.initial:
      case AppState.authenticating:
        return InitialScreen();
      //  return AuthenticatingScreen();
      case AppState.authenticated:
        return DashboardScreen();
      case AppState.unauthenticated:
        return LoginScreen();
    }
  }
}
