import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Config Flavor Text style
///
class BodyText1 extends StatelessWidget {
  const BodyText1({Key? key, required this.text}) : super(key: key);
  final String text;

  transformToUpper() {
    String? sentence = toBeginningOfSentenceCase(text);
    return sentence;
  }

  @override
  Widget build(BuildContext context) {
    return text.isEmpty
        ? SizedBox.shrink()
        : Text(transformToUpper(),
            style: Theme.of(context).textTheme.bodyText1);
  }
}
