import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubtitleText1 extends StatelessWidget {
  const SubtitleText1({Key? key, required this.text}) : super(key: key);
  final String text;

  transformToUpper() {
    String? sentence = toBeginningOfSentenceCase(text);
    return sentence;
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      transformToUpper(),
      style: Theme.of(context).textTheme.subtitle1,
      maxLines: 1,
      maxFontSize: Theme.of(context).textTheme.subtitle1!.fontSize!,
    );
  }
}
