import 'package:flutter/material.dart';

enum ContactFormValidation {
  notempty,
  text,
  discription,
  email,
  phone,
  url,
  twitter,
  facebook,
  linkedIn
}

class ContactFormField extends StatefulWidget {
  const ContactFormField({
    required this.leading,
    this.trailing,
    required this.value,
    required this.hint,
    required this.type,
    required this.function,
  });
  final Widget leading;
  final Widget? trailing;
  final String? value;
  final String hint;
  final ContactFormValidation type;
  final Function function;

  @override
  _ContactFormFieldState createState() => _ContactFormFieldState();
}

class _ContactFormFieldState extends State<ContactFormField> {
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
      case ContactFormValidation.twitter:
        return '@ ';
      case ContactFormValidation.phone:
        return '+31 ';
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
      case ContactFormValidation.notempty:
        if (value!.isEmpty) {
          return 'Dit veldt mag niet leeg zijn';
        } else {
          return null;
        }
      case ContactFormValidation.text:
      case ContactFormValidation.discription:
        return null;

      case ContactFormValidation.phone:
        if (value!.isNotEmpty && !value.contains(RegExp(r'[0-9]'))) {
          return 'Voer een geldige telefoonnummer in';
        } else {
          return null;
        }

      case ContactFormValidation.url:
        if (value!.isNotEmpty && !value.contains('.') && value.length < 6) {
          return 'Voer een geldige website url in';
        } else {
          return null;
        }

      case ContactFormValidation.twitter:
        if (value!.isNotEmpty && (value.contains('@') || value.length > 15)) {
          return 'Voer alleen uw twitter naam in zonder @';
        } else {
          return null;
        }

      case ContactFormValidation.facebook:
        if (value!.isNotEmpty && !value.contains('facebook.com/')) {
          return 'Voer een geldige facebook url in';
        } else {
          return null;
        }
      case ContactFormValidation.linkedIn:
        if (value!.isNotEmpty && !value.contains('linkedin.com/')) {
          return 'Voer een geldige linkedIn url in';
        } else {
          return null;
        }
      case ContactFormValidation.email:
        if (value!.isNotEmpty && !value.contains('@')) {
          return 'Voer een geldige emailadress in';
        } else {
          return null;
        }
    }
  }

  TextInputType keyboardInputType() {
    switch (widget.type) {
      case ContactFormValidation.phone:
        return TextInputType.number;
      case ContactFormValidation.text:
      case ContactFormValidation.discription:
      case ContactFormValidation.notempty:
        return TextInputType.text;

      case ContactFormValidation.url:
      case ContactFormValidation.twitter:
      case ContactFormValidation.facebook:
      case ContactFormValidation.linkedIn:
        return TextInputType.url;
      case ContactFormValidation.email:
        return TextInputType.emailAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: widget.leading,
        title: TextFormField(
          autofocus: false,
          keyboardType: keyboardInputType(),
          style: Theme.of(context).textTheme.bodyText1,
          minLines: widget.type == ContactFormValidation.discription ? 15 : 1,
          maxLines: widget.type == ContactFormValidation.discription ? 20 : 1,
          controller: controller,
          decoration: inputDecoration(),
          onSaved: (value) => widget.function(value),
          validator: (value) => formValidation(value),
          enabled: ContactFormValidation.email == widget.type ? false : true,
        ),
        trailing: widget.trailing ?? SizedBox.shrink(),
      ),
    );
  }
}
