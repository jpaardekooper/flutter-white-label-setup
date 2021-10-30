import 'package:base/state/event_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventPlanner extends StatefulWidget {
  const EventPlanner({Key? key}) : super(key: key);

  @override
  _EventPlannerState createState() => _EventPlannerState();
}

class _EventPlannerState extends State<EventPlanner> {
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

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (eventState.selectedUserForEvent?.isGoing == 0) {
                      return;
                    } else {
                      Provider.of<EventState>(context, listen: false)
                          .attendEvent(0);
                    }
                  });
                },
                child: Ink(
                  color: eventState.selectedUserForEvent?.isGoing == 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  child: attendance('Aanwezig'),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (eventState.selectedUserForEvent?.isGoing == 1) {
                      return;
                    } else {
                      Provider.of<EventState>(context, listen: false)
                          .attendEvent(1);
                    }
                  });
                },
                child: Ink(
                  color: eventState.selectedUserForEvent?.isGoing == 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  child: attendance('Misschien'),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (eventState.selectedUserForEvent?.isGoing == 2) {
                      return;
                    } else {
                      Provider.of<EventState>(context, listen: false)
                          .attendEvent(2);
                    }
                  });
                },
                child: Ink(
                  color: eventState.selectedUserForEvent?.isGoing == 2
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  child: attendance('Niet aanwezig'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
