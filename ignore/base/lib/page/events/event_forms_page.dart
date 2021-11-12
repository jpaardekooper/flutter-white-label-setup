import 'package:base/ui/widgets/event/forms/event_edit_form.dart';
import 'package:base/ui/widgets/event/forms/event_form.dart';
import 'package:flutter/material.dart';

class EventFormPage extends StatelessWidget {
  const EventFormPage({Key? key, required this.edit}) : super(key: key);
  final bool edit;
  @override
  Widget build(BuildContext context) {
    //   var eventState = Provider.of<EventState>(context, listen: true);
    return edit ? EventEditForm() : EventForm();
  }
}
