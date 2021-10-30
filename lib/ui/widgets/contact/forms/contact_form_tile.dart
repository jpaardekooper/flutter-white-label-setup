import 'package:base/ui/widgets/text/body_text_1.dart';
import 'package:flutter/material.dart';

class ContactFormTile extends StatelessWidget {
  const ContactFormTile(
      {Key? key, this.leading, this.trailing, required this.text})
      : super(key: key);
  final Widget? leading;
  final Widget? trailing;
  final String text;

  @override
  Widget build(BuildContext context) {
    return text.isNotEmpty
        ? ListTile(
            leading: leading ?? SizedBox(),
            title: BodyText1(
              text: text,
            ),
            trailing: trailing ?? SizedBox(),
          )
        : SizedBox.shrink();
  }
}
