import 'package:base/models/events.dart';
import 'package:base/page/events/event_detail.dart';
import 'package:base/state/event_state.dart';

import 'package:base/ui/widgets/text/text_with_shadow.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class EventTiles extends StatelessWidget {
  EventTiles(this.event);
  final Events event;

  InkWell eventTile(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<EventState>(context, listen: false).setSelectedEvent(event);

        // await Navigator.push(context, createRouteTransistion(EventDetail()));

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: EventDetail(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithShadow(
                    text: DateFormat.yMMMMEEEEd('nl').format(event.startDate!),
                    size: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWithShadow(
                        text: DateFormat.Hm('nl').format(event.startDate!),
                        size: 17),
                    TextWithShadow(text: '-', size: 17),
                    TextWithShadow(
                        text: DateFormat.Hm('nl').format(event.endDate!),
                        size: 17)
                  ],
                )
              ],
            ),
            TextWithShadow(text: event.title ?? '', size: 21),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Stack(
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'config/assets/images/logo.png',
              image:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            eventTile(context)
          ],
        )

        //  Ink.image(
        //   fit: BoxFit.cover,
        //   image: NetworkImage(event.visualImage == null ||
        //           event.visualImage!.isEmpty ||
        //           !event.visualImage!.contains('www')
        //       ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s'
        //       : event.visualImage!),
        //   child: ,
        // ),
        );
  }
}
