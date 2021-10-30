import 'package:flutter/material.dart';

enum EventFormValidation {
  text,
  discription,
  url,
  dateTime,
  gps,
}

class EventFormField extends StatefulWidget {
  const EventFormField({
    required this.value,
    required this.hint,
    required this.type,
    required this.function,
  });
  final String? value;
  final String hint;
  final EventFormValidation type;
  final Function? function;

  @override
  _EventFormFieldState createState() => _EventFormFieldState();
}

class _EventFormFieldState extends State<EventFormField> {
  late TextEditingController controller;
  late FocusNode focus;
  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    focus = FocusNode();
    controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();

    super.dispose();
  }

  setPrefixIcon() {
    switch (widget.type) {
      default:
        return null;
    }
  }

  inputDecoration() {
    return InputDecoration(
        contentPadding: EdgeInsets.all(8),
        border: OutlineInputBorder(),
        prefixText: setPrefixIcon(),
        disabledBorder: InputBorder.none,
        labelStyle: TextStyle(
          color: focus.hasFocus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          fontSize: 16,
        ),
        labelText: widget.hint);
  }

  formValidation(String? value) {
    switch (widget.type) {
      case EventFormValidation.text:
      case EventFormValidation.discription:
        return null;

      case EventFormValidation.url:
        if (value!.isNotEmpty && !value.contains('www.')) {
          return 'Voer een geldige website url in';
        } else {
          return null;
        }

      default:
        return null;
    }
  }

  TextInputType keyboardInputType() {
    switch (widget.type) {
      case EventFormValidation.text:
      case EventFormValidation.discription:
        return TextInputType.text;

      case EventFormValidation.url:
        return TextInputType.url;
      case EventFormValidation.dateTime:
        return TextInputType.datetime;
      case EventFormValidation.gps:
        return TextInputType.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          TextFormField(
              enabled: widget.type == EventFormValidation.dateTime ||
                      widget.type == EventFormValidation.gps
                  ? false
                  : true,
              keyboardType: keyboardInputType(),
              style: Theme.of(context).textTheme.bodyText1,
              minLines: widget.type == EventFormValidation.discription ? 10 : 1,
              maxLines: widget.type == EventFormValidation.discription ? 20 : 1,
              controller: controller,
              decoration: inputDecoration(),
              onSaved: (value) => widget.function!(value),
              validator: (value) => formValidation(value)
              // if (value == null || value.isEmpty) {
              //   return 'Please enter some text';
              // }
              // return null;
              //  },
              ),
        ],
      ),
    );
  }
}
