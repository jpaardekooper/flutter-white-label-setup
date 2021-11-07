import 'package:base/models/event_users.dart';
import 'package:base/state/event_state.dart';
import 'package:base/ui/widgets/event/attendance/button_show_event_dialog.dart';
import 'package:base/ui/widgets/event/attendance/cached_event_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserGoing extends StatefulWidget {
  const UserGoing({Key? key}) : super(key: key);

  @override
  _UserGoingState createState() => _UserGoingState();
}

class _UserGoingState extends State<UserGoing> {
  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);

    return eventState.going.isEmpty
        ? SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: eventState.going.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, index) {
                      EventUsers eventUser = eventState.going[index];
                      if (index < 7) {
                        return Align(
                          widthFactor: eventState.going.length < 6 ? 1 : 0.7,
                          alignment: Alignment.topLeft,
                          child: Tooltip(
                            message: '${eventUser.userName}',
                            child: CachedEventImage(eventUser.userImage ?? '',
                                60, 60, 'event', eventUser.takesGuest),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ),
              ButtonShowEventDialog(
                  list: eventState.going, message: 'Aanwezige lijst'),
            ],
          );
  }
}
