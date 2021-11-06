import 'package:base/state/event_state.dart';
import 'package:base/ui/widgets/components/buttons/event_back_button.dart';
import 'package:base/ui/widgets/event/buttons/toggle_edit.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:base/ui/widgets/event/event_header.dart';
import 'package:config/flavor_assets.dart';
import 'package:dart_twitter_api/api/media/data/media.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_forms_page.dart';

class EventDetail extends StatefulWidget {
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  void initState() {
    super.initState();

    Provider.of<EventState>(context, listen: false).fetchEventsById();
  }

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: false);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        eventState.toggleEditToFalse();
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppbarLogo(),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: AppBackButton(function: eventState.toggleEditToFalse),
          actions: [
            ToggleEditEvent(
              function: eventState.toggleEdit,
            )
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            EventHeader(),
            EventFormPage(),
          ],
        ),
      ),
    );
  }
}
