import 'package:base/models/events.dart';
import 'package:base/page/events/event_detail.dart';
import 'package:base/state/event_state.dart';
import 'package:base/page/ui/widgets/components/dissmissble_page.dart';

import 'package:base/page/ui/widgets/text/text_with_shadow.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class EventTiles extends StatefulWidget {
  EventTiles(this.event);
  final Events event;

  @override
  State<EventTiles> createState() => _EventTilesState();
}

class _EventTilesState extends State<EventTiles> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 8),
      //  minVerticalPadding: 0,
      onTap: () {
        Provider.of<EventState>(context, listen: false)
            .setSelectedEvent(widget.event);

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: DissmissibleAppPage(child: EventDetail()),
            ctx: context,
          ),
        );
      },
      // Renders a `Material` in its build method
      title: Ink.image(
        image: CachedNetworkImageProvider(
          widget.event.visualImage == null ||
                  widget.event.visualImage!.isEmpty ||
                  !widget.event.visualImage!.contains('www')
              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s'
              : widget.event.visualImage!,
        ),
        fit: BoxFit.cover,
        child: InkWell(
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
                      text: DateFormat.yMMMMEEEEd('nl')
                          .format(widget.event.startDate!),
                      size: 18,
                      alignment: Alignment.topLeft,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWithShadow(
                          text: DateFormat.Hm('nl')
                              .format(widget.event.startDate!),
                          size: 17,
                          alignment: Alignment.topLeft,
                        ),
                        TextWithShadow(
                          text: '-',
                          size: 17,
                          alignment: Alignment.topLeft,
                        ),
                        TextWithShadow(
                          text:
                              DateFormat.Hm('nl').format(widget.event.endDate!),
                          size: 17,
                          alignment: Alignment.topLeft,
                        )
                      ],
                    )
                  ],
                ),
                TextWithShadow(
                  text: widget.event.title ?? '',
                  size: 21,
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
