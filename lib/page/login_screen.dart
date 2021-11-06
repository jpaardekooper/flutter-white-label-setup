import 'package:base/page/reset_passwordscreen.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:base/ui/widgets/login/password_textfield.dart';
import 'package:base/ui/widgets/login/username_textfield.dart';
import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';
import 'package:base/state/auth_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  _showErrorMessage(String value) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[100],
        behavior: SnackBarBehavior.floating,
        content: ListTile(
          dense: true,
          leading: Icon(
            Icons.error,
            color: Colors.red,
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.red),
              ),
              Text(
                'Gebruikersnaam en wachtwoord komen niet overeen',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    if (!_formKey.currentState!.validate()) return;
    var authState = Provider.of<AuthState>(context, listen: false);

    await authState.login(authState.username, authState.password).then((value) {
      authState.setLoadingToFalse();
      if (value == 200) {
        authState.setInitial();
      } else {
        _showErrorMessage(value);
      }
    }, onError: (error) {
      _showErrorMessage(error.toString());
    });
  }

  Widget buttonLogin() {
    return SizedBox(
      height: 45,
      key: Key('login'),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.primary, // background
        ),
        onPressed: _submit,
        child: const Text(
          'Login',
        ),
      ),
    );
  }

  Widget resetPassword() {
    return SizedBox(
      key: Key('resetPassword'),
      child: TextButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(),
            ),
          );
        },
        child: Text('Wachtwoord vergeten?',
            style: Theme.of(context).textTheme.bodyText2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Logo(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  UsernameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  Provider.of<AuthState>(context).loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary),
                        )
                      : buttonLogin(),
                  SizedBox(
                    height: 10,
                  ),
                  resetPassword(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
