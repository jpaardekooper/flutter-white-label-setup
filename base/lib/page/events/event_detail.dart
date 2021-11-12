import 'package:base/page/ui/widgets/components/logo.dart';
import 'package:base/page/ui/widgets/event/buttons/toggle_edit.dart';
import 'package:base/page/ui/widgets/event/event_header.dart';
import 'package:base/state/app_editing_state.dart';
import 'package:base/state/event_state.dart';
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
    return ChangeNotifierProvider<AppEditingState>(
      create: (_) => AppEditingState(),
      child: Scaffold(
        appBar: AppBar(
          title: AppbarLogo(),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [ToggleEditEvent()],
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
