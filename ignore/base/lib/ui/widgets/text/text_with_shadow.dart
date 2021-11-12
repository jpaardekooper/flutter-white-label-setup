import 'package:config/contact/contact_styling_theme.dart';
import 'package:flutter/material.dart';

class TextWithShadow extends StatelessWidget {
  const TextWithShadow(
      {Key? key,
      required this.text,
      required this.size,
      required this.alignment})
      : super(key: key);
  final String text;
  final double size;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: alignment,
          child: ContactDetailProfileBackground(
            text: text,
          ),
        ),
        Align(
          alignment: alignment,
          child: ContactDetailProfileFront(
            text: text,
          ),
        ),
        //      Solid text as fill.
      ],
    );
  }
}
