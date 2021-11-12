import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubtitleText2 extends StatelessWidget {
  const SubtitleText2({Key? key, required this.subtitle}) : super(key: key);
  final String subtitle;

  transformToUpper() {
    String? sentence = toBeginningOfSentenceCase(subtitle);
    return sentence;
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      transformToUpper(),
      style: Theme.of(context).textTheme.subtitle2,
      maxLines: 1,
      maxFontSize: Theme.of(context).textTheme.subtitle2!.fontSize!,
    );
  }
}
