import 'dart:convert';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_config/flutter_config.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;

  late FocusNode usernameNode;

  @override
  void initState() {
    usernameController = TextEditingController();
    usernameNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    usernameNode.dispose();

    super.dispose();
  }

  _submit() async {
    try {
      var result;

      Map<String, dynamic> loginData = {
        'emailAddress': usernameController.text,
      };

      Response response = await post(
        Uri.parse(
            "https://contactapp-api-test.azurewebsites.net/accounts/request-password-reset"),
        body: jsonEncode(loginData),
        headers: {
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'Content-Type': 'application/json',
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
        },
      );

      if (response.statusCode == 200) {
        result = response.body;
      }

      // return result;
    } on Exception catch (_) {
      throw _;
    }
  }

  Widget buttonResetpassword() {
    return SizedBox(
      height: 45,
      key: Key('requestpassword'),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.primary, // background
        ),
        onPressed: _submit,
        child: const Text(
          'Wachtwoord resetten',
        ),
      ),
    );
  }

  void _requestFocus(FocusNode currentNode) {
    setState(() {
      FocusScope.of(context).requestFocus(currentNode);
    });
  }

  inputDecoration(FocusNode focus, String label, Icon icon) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      labelStyle: TextStyle(
          color: focus.hasFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          fontSize: 14),
      prefixIcon: icon,
      labelText: 'Gebruikersnaam',
    );
  }

  TextFormField inputEmail() {
    return TextFormField(
      controller: usernameController,
      focusNode: usernameNode,
      textInputAction: TextInputAction.next,
      onTap: () {
        _requestFocus(usernameNode);
      },
      keyboardType: TextInputType.emailAddress,
      decoration: inputDecoration(
        usernameNode,
        'Gebruikersnaam',
        Icon(
          Icons.person,
          color: usernameNode.hasFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
      validator: (String? value) {
        return value == null || !value.contains('@') ? 'Invalid email!' : null;
      },
    );
  }

  Widget backToLogin() {
    return SizedBox(
      key: Key('resetPassword'),
      child: TextButton(
          onPressed: () {
            usernameNode.unfocus();
            Navigator.pop(context);
          },
          child: Text('Terug naar inloggen',
              style: Theme.of(context).textTheme.bodyText2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Hero(
                  tag: 'logo',
                  child: Logo(scale: FlavorAssets.scale),
                ),
                SizedBox(
                  height: 40,
                ),
                inputEmail(),
                SizedBox(
                  height: 20,
                ),
                buttonResetpassword(),
                SizedBox(
                  height: 10,
                ),
                backToLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
