import 'package:base/state/event_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventPlanner extends StatefulWidget {
  const EventPlanner({Key? key}) : super(key: key);

  @override
  _EventPlannerState createState() => _EventPlannerState();
}

class _EventPlannerState extends State<EventPlanner> {
  int? groupValue = 0;

  Container attendance(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      height: 40,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildSegment(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      alignment: Alignment.center,
      child: Text(
        text,
        textScaleFactor: 1,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoSlidingSegmentedControl<int>(
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        thumbColor: Theme.of(context).colorScheme.primary,
        groupValue: Provider.of<EventState>(context, listen: false)
            .selectedUserForEvent
            ?.isGoing,
        children: {
          0: buildSegment("Aanwezig"),
          1: buildSegment("Misschien"),
          2: buildSegment("Niet aanwezig"),
        },
        onValueChanged: (value) {
          setState(() {
            groupValue = value;
            Provider.of<EventState>(context, listen: false)
                .attendEvent(groupValue!);
          });
        },
      ),
    );
  }
}
