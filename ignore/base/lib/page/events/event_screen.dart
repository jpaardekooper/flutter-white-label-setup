import 'package:base/models/events.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:base/ui/widgets/event/event_tiles.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:base/state/event_state.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EventState>(context, listen: false).fetchEvents();
  }

  Future<void> _refreshData() async {
    await Provider.of<EventState>(context, listen: false).fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    var events = Provider.of<EventState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppbarLogo(),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: events.eventsList.isEmpty
          ? LoadingState(message: 'Evenementen worden ingeladen')
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: Scrollbar(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  shrinkWrap: false,
                  itemCount: events.eventsList.length,
                  itemExtent: 250,
                  itemBuilder: (BuildContext ctxt, int index) {
                    Events _event = events.eventsList[index];

                    return EventTiles(_event);
                  },
                ),
              ),
            ),
    );
  }
}
