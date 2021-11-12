import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateTimeButton extends StatefulWidget {
  const DateTimeButton(
      {Key? key, required this.function, required this.datetime})
      : super(key: key);
  final Function function;
  final DateTime? datetime;

  @override
  _DateTimeButtonState createState() => _DateTimeButtonState();
}

class _DateTimeButtonState extends State<DateTimeButton> {
  String date = 'aaaaa';
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        DatePicker.showDateTimePicker(context, showTitleActions: true,
            onChanged: (date) {
          // print('change $date in time zone ' +
          //     date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          // print('confirm $date');
          widget.function(date);
        },
            currentTime: widget.datetime ?? DateTime.now(),
            locale: LocaleType.nl);
      },
      icon: Icon(Icons.timer),
    );
  }
}
