import 'package:base/models/event_users.dart';
import 'package:base/state/event_state.dart';
import 'package:base/ui/widgets/event/attendance/button_show_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cached_event_image.dart';

class UserNotGoing extends StatefulWidget {
  const UserNotGoing({Key? key}) : super(key: key);

  @override
  _UserNotGoingState createState() => _UserNotGoingState();
}

class _UserNotGoingState extends State<UserNotGoing> {
  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);

    return eventState.notGoing.isEmpty
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
                    itemCount: eventState.notGoing.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, index) {
                      EventUsers eventUser = eventState.notGoing[index];
                      if (index < 7) {
                        return Align(
                          widthFactor: eventState.notGoing.length < 6 ? 1 : 0.7,
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
                  list: eventState.notGoing, message: 'Niet aanwezige lijst'),
            ],
          );
  }
}
