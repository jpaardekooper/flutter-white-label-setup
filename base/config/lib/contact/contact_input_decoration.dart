import 'package:flutter/material.dart';

InputDecoration contactInputDecoration(String? preFix, String? hint) {
  return InputDecoration(
    floatingLabelStyle: TextStyle(color: Colors.blue.shade200),
    contentPadding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
    //  border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade700, width: 0.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.shade300, width: 1.0),
    ),
    prefixText: preFix,

    disabledBorder: InputBorder.none,
    //  suffixStyle: ,
    labelStyle: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 13,
    ),
    labelText: hint,
  );
}
