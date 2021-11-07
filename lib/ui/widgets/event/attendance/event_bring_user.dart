import 'package:base/state/event_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BringUser extends StatefulWidget {
  const BringUser({Key? key}) : super(key: key);

  @override
  _BringUserState createState() => _BringUserState();
}

class _BringUserState extends State<BringUser> {
  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);
    return eventState.selectedUserForEvent == null
        ? SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 23,
                padding: EdgeInsets.all(0),
                child: Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Theme.of(context).colorScheme.primary,
                    checkColor: Colors.white,
                    onChanged: (value) {
                      eventState.attendEvent(
                          eventState.selectedUserForEvent?.isGoing ?? -1);
                      setState(() {
                        eventState.selectedUserForEvent?.takesGuest = value;
                      });
                    },
                    value: eventState.selectedUserForEvent?.takesGuest ?? false,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Ik neem een introducee mee',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          );
  }
}
