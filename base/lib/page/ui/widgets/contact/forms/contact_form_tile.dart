import 'package:base/page/ui/widgets/text/body_text_2.dart';
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
            // contentPadding: EdgeInsets.only(left: 16),
            dense: true,
            leading: leading ?? SizedBox(),
            title: BodyText2(
              text: text,
            ),
            trailing: trailing ?? SizedBox(),
          )
        : SizedBox.shrink();
  }
}
