import 'package:base/state/auth_state.dart';
import 'package:base/ui/widgets/custom_icons/key_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'input_decoration.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late TextEditingController passwordController;

  late FocusNode passwordNode;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      controller: passwordController,
      focusNode: passwordNode,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onSaved: (value) =>
          Provider.of<AuthState>(context, listen: false).setPassword(value!),
      obscureText: true,
      onFieldSubmitted: (term) {
        passwordNode.unfocus();
      },
      onTap: () {
        passwordNode.requestFocus();
      },
      decoration: inputDecoration(
        passwordNode,
        'Wachtwoord',
        Icon(
          CustomKeyIcon.key,
          size: 16,
          color: passwordNode.hasFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
        context,
      ),
      validator: (value) => value!.isEmpty ? "Vul uw wachtwoord in" : null,
    );
  }
}
