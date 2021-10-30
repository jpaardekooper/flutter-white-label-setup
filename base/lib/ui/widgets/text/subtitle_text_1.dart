import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubtitleText1 extends StatelessWidget {
  const SubtitleText1({Key? key, required this.subtitle}) : super(key: key);
  final String subtitle;

  transformToUpper() {
    String? sentence = toBeginningOfSentenceCase(subtitle);
    return sentence;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      transformToUpper(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
