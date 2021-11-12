import 'package:base/page/ui/widgets/event/forms/event_edit_form.dart';
import 'package:base/page/ui/widgets/event/forms/event_form.dart';
import 'package:base/state/app_editing_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventFormPage extends StatelessWidget {
  const EventFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appEditState = Provider.of<AppEditingState>(context, listen: true);
    return appEditState.EditStatus ? EventEditForm() : EventForm();
  }
}
