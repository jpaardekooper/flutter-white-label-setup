import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContactTileHeading extends StatelessWidget {
  const ContactTileHeading({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
      maxFontSize: Theme.of(context).textTheme.bodyText1!.fontSize!,
      stepGranularity: 1,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ContactTileBody extends StatelessWidget {
  const ContactTileBody({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primaryVariant,
          fontWeight: FontWeight.w400,
          fontSize: 16),
      minFontSize: Theme.of(context).textTheme.bodyText2!.fontSize!,
      maxFontSize: Theme.of(context).textTheme.bodyText2!.fontSize!,
      stepGranularity: 1,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ContactDetailProfileFront extends StatelessWidget {
  const ContactDetailProfileFront({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontSize: 18,
        foreground: Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 1
          ..color = Colors.white,
      ),
      minFontSize: 12,
      maxFontSize: 18,
      stepGranularity: 1,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ContactDetailProfileBackground extends StatelessWidget {
  const ContactDetailProfileBackground({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontSize: 18,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black,
      ),
      minFontSize: 12,
      maxFontSize: 18,
      stepGranularity: 1,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
