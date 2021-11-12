import 'package:base/state/event_state.dart';
import 'package:base/ui/widgets/event/event.maps.dart';
import 'package:base/ui/widgets/event/eventform_validation_field.dart';
import 'package:base/ui/widgets/event/forms/date_time_button.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
import 'package:base/ui/widgets/text/subtitle_text_1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class EventEditForm extends StatelessWidget {
  EventEditForm({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  Widget spaceWidget(double size) {
    return SizedBox(height: size);
  }

  Future<String> getValue() async {
    await Future.delayed(Duration(seconds: 0));

    return 'completed';
  }

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);

    return eventState.eventsList.isEmpty
        ? const LoadingState(message: 'Evenement informatie')
        : Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: EventFormField(
                      hint: 'Url:',
                      type: EventFormValidation.url,
                      value: eventState.selectedEvent.url,
                      function: eventState.updateUrl,
                    ),
                  ),
                  ListTile(
                    enabled: false,
                    title: Text(
                      'Begint om:',
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMEEEEd('nl')
                              .format(eventState.selectedEvent.startDate!) +
                          " " +
                          DateFormat.jm('nl')
                              .format(eventState.selectedEvent.startDate!),
                    ),
                    trailing: DateTimeButton(
                      function: eventState.updateStartDate,
                      datetime: eventState.selectedEvent.startDate,
                    ),
                  ),
                  ListTile(
                    enabled: false,
                    title: Text(
                      'Eindigt op:',
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMEEEEd('nl')
                              .format(eventState.selectedEvent.endDate!) +
                          " " +
                          DateFormat.jm('nl')
                              .format(eventState.selectedEvent.endDate!),
                    ),
                    trailing: DateTimeButton(
                      function: eventState.updateEndDate,
                      datetime: eventState.selectedEvent.endDate,
                    ),
                  ),
                  Divider(),
                  spaceWidget(16),
                  ListTile(
                    title: EventFormField(
                      hint: 'Titel',
                      type: EventFormValidation.text,
                      value: eventState.selectedEvent.title,
                      function: eventState.updateTitle,
                    ),
                  ),
                  ListTile(
                    title: EventFormField(
                      hint: 'Beschrijving',
                      type: EventFormValidation.discription,
                      value: eventState.selectedEvent.description,
                      function: eventState.updateDescription,
                    ),
                  ),
                  Divider(),
                  spaceWidget(16),
                  SubtitleText1(text: 'Locatie'),
                  spaceWidget(8),
                  ListTile(
                    title: EventFormField(
                      hint: 'Plaatsnaam',
                      type: EventFormValidation.text,
                      value: eventState.selectedEvent.venueName,
                      function: eventState.updateVenueName,
                    ),
                  ),
                  spaceWidget(8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 400,
                      child: EventMaps(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();
                            FocusScope.of(context).unfocus();
                            if (!formKey.currentState!.validate()) return;

                            bool? result = await eventState
                                .updateSelectedEventInformation();

                            if (result!) {
                              // Provider.of<EventState>(context, listen: false)
                              //     .toggleEditToFalse();
                            } else {}
                          },
                          child: Text('Opslaan'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
