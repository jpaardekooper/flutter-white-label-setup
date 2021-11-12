import 'package:base/state/event_state.dart';
import 'package:base/ui/widgets/event/attendance/event_bring_user.dart';
import 'package:base/ui/widgets/event/attendance/event_planner.dart';
import 'package:base/ui/widgets/event/attendance/user_going.dart';
import 'package:base/ui/widgets/event/attendance/user_maybe_going.dart';
import 'package:base/ui/widgets/event/attendance/user_not_going.dart';
import 'package:base/ui/widgets/event/event.maps.dart';
import 'package:base/ui/widgets/text/body_text_1.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
import 'package:base/ui/widgets/text/subtitle_text_1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventForm extends StatelessWidget {
  const EventForm({Key? key}) : super(key: key);

  Widget spaceWidget(double size) {
    return SizedBox(height: size);
  }

  Future<String> loadGoogleMaps() async {
    await Future.delayed(Duration(seconds: 2));

    return 'loaded';
  }

  Future<void> launchUrl(String? webUrl) async {
    if (webUrl == null) {
      return;
    }
    try {
      await launch(webUrl, forceSafariVC: false);
    } catch (e) {
      await launch(webUrl, forceSafariVC: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);

    return eventState.eventsList.isEmpty
        ? const LoadingState(message: 'Evenement informatie')
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(left: 8),
                  minVerticalPadding: 0,
                  minLeadingWidth: 5,
                  leading: Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  dense: true,
                  title: SubtitleText1(
                    text: DateFormat.yMMMMd('nl')
                        .format(eventState.selectedEvent.startDate!),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 8),
                  minVerticalPadding: 0,
                  minLeadingWidth: 5,
                  leading: Icon(
                    Icons.timer,
                    size: 20,
                  ),
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyText1(
                        text: 'Van ' +
                            DateFormat('kk:mm')
                                .format(eventState.selectedEvent.startDate!) +
                            ' tot ',
                      ),
                      BodyText1(
                        text: DateFormat.Hm('nl')
                            .format(eventState.selectedEvent.endDate!),
                      ),
                    ],
                  ),
                ),
                eventState.selectedEvent.url == null ||
                        eventState.selectedEvent.url!.isEmpty
                    ? SizedBox()
                    : TextButton(
                        onPressed: () =>
                            launchUrl(eventState.selectedEvent.url),
                        child: Text(eventState.selectedEvent.url ?? '')),
                Divider(),
                spaceWidget(16),
                SubtitleText1(text: 'Bent u aanwezig?'),
                spaceWidget(16),
                EventPlanner(),

                spaceWidget(16),
                eventState.selectedEvent.mayTakeGuest!
                    ? BringUser()
                    : SizedBox.shrink(),
                spaceWidget(16),
                Divider(),
                spaceWidget(16),
                SubtitleText1(
                  text: eventState.selectedEvent.title ?? '',
                ),
                spaceWidget(8),
                BodyText1(
                  text: eventState.selectedEvent.description ?? '',
                ),
                spaceWidget(16),
                Divider(),
                spaceWidget(16),
                SubtitleText1(text: 'Locatie'),
                spaceWidget(8),
                BodyText1(
                  text: eventState.selectedEvent.venueName ?? '',
                ),
                spaceWidget(16),
                FutureBuilder<String>(
                  future: loadGoogleMaps(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 250,
                        child: EventMaps(),
                      );
                    }
                    return SizedBox();
                  },
                ),
                spaceWidget(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubtitleText1(text: 'Aanwezig'),
                    Text(eventState.going.length.toString())
                  ],
                ),
                spaceWidget(8),
                UserGoing(),
                //widget soon
                Divider(),
                spaceWidget(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubtitleText1(text: 'Misschien'),
                    Text(eventState.maybeGoing.length.toString())
                  ],
                ),
                spaceWidget(8),
                UserMaybeGoing(),
                //widget soon
                Divider(),
                spaceWidget(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubtitleText1(text: 'Niet aanwezig'),
                    Text(eventState.notGoing.length.toString())
                  ],
                ),
                spaceWidget(8),
                UserNotGoing(),
              ],
            ),
          );
  }
}
