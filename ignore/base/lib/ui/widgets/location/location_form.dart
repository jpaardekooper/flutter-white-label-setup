import 'package:flutter/material.dart';

enum TextType { text, description, autofill }

class LocationFormField extends StatefulWidget {
  const LocationFormField(
      {required this.value,
      required this.hint,
      required this.canEdit,
      required this.theme,
      required this.type});
  final String value;
  final String hint;
  final bool canEdit;
  final theme;
  final TextType type;
  @override
  _LocationFormFieldState createState() => _LocationFormFieldState();
}

class _LocationFormFieldState extends State<LocationFormField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    focus = FocusNode();
    controller.text = widget.value;
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    super.dispose();
  }

  late FocusNode focus;

  inputDecoration() {
    return InputDecoration(
      // focusedBorder: UnderlineInputBorder(
      //   borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      // ),
      contentPadding: EdgeInsets.all(8),
      border: OutlineInputBorder(),
      disabledBorder: InputBorder.none,
      labelStyle: TextStyle(
        color: focus.hasFocus
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        fontSize: 14,
      ),
      labelText: widget.hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.canEdit
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              readOnly: widget.type == TextType.autofill ? true : false,
              enabled: widget.type == TextType.autofill ? false : true,
              minLines: widget.type == TextType.description ? 15 : 1,
              maxLines: widget.type == TextType.description ? 25 : 1,
              autofocus: false,
              controller: controller,
              decoration: inputDecoration(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          )
        : Text(
            widget.value,
            textAlign: TextAlign.start,
            style: widget.theme,
          );
  }
}
