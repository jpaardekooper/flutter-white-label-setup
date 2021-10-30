import 'package:base/models/app_user.dart';
import 'package:base/page/dashboard_screen.dart';
import 'package:base/page/login_screen.dart';
import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';
import 'package:base/state/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late Future<AppUser?> checkSession;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    checkSession =
        Provider.of<AuthState>(context, listen: false).checkConnection();
  }

  Widget showLogo() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Hero(
          tag: 'logo',
          child: Image.asset(FlavorAssets.splash, scale: FlavorAssets.scale),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AppUser?>(
        future: checkSession,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return showLogo();
            case ConnectionState.done:
              if (snapshot.hasError || snapshot.data == null) {
                return LoginScreen();
              } else {
                //if all checks are marked good go to dashboard screen
                return DashboardScreen();
              }

            default:
              return showLogo();
          }
        },
      ),
    );
  }
}
