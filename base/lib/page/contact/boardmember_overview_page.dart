import 'package:base/models/contact_user.dart';
import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/contact/tiles/contact_tile.dart';
import 'package:base/ui/widgets/text/error_message.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardMemberOverview extends StatefulWidget {
  const BoardMemberOverview({Key? key}) : super(key: key);

  @override
  State<BoardMemberOverview> createState() => _BoardMemberOverviewState();
}

class _BoardMemberOverviewState extends State<BoardMemberOverview>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Provider.of<ContactState>(context, listen: false).fetchBoardmemberData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var contactState = Provider.of<ContactState>(context, listen: true);

    return contactState.listOfBoardMembers.isEmpty
        ? contactState.searchToggle
            ? NoDataMessage(message: 'Er is geen overeenkomst gevonden')
            : LoadingState(message: 'Bestuursleden')
        : ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount: contactState.listOfBoardMembers.length,
            itemBuilder: (BuildContext ctxt, int index) {
              ContactUser contact = contactState.listOfBoardMembers[index];
              return ContactTiles(contact, 'b');
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
