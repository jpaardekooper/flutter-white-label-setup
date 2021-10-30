import 'package:flutter/material.dart';

inputDecoration(
    FocusNode focus, String label, Icon icon, BuildContext context) {
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
    labelText: label,
  );
}
