import 'package:base/state/event_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventHeader extends StatelessWidget {
  const EventHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);
    return Container(
      height: 250,
      child: Material(
        child: Stack(
          children: [
            Ink.image(
              fit: BoxFit.cover,
              image: NetworkImage(eventState.selectedEvent.visualImage ==
                          null ||
                      eventState.selectedEvent.visualImage!.isEmpty ||
                      !eventState.selectedEvent.visualImage!.contains('www')
                  ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s'
                  : eventState.selectedEvent.visualImage!),
            ),
          ],
        ),
      ),
    );
  }
}
