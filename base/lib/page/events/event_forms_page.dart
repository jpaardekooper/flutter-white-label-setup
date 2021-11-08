import 'package:base/state/event_state.dart';
import 'package:base/ui/widgets/event/forms/event_edit_form.dart';
import 'package:base/ui/widgets/event/forms/event_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventFormPage extends StatelessWidget {
  const EventFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);
    return eventState.edit ? EventEditForm() : EventForm();
  }
}
