import 'package:flutter/material.dart';
import 'package:base/helper/shared_preference.dart';
import 'package:base/state/auth_state.dart';
import 'package:base/state/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<DashboardViewModel>(context, listen: false)
            .setCurrentIndex(0);
        Provider.of<LocalStorage>(context, listen: false).clearSession();
        Provider.of<AuthState>(context, listen: false).logout();
      },
      child: Text('uitloggen'),
    );
  }
}
