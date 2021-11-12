import 'package:base/models/contact_user.dart';
import 'package:base/page/ui/widgets/contact/tiles/contact_favorite_tiles.dart';
import 'package:base/page/ui/widgets/text/error_message.dart';
import 'package:base/page/ui/widgets/text/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

class FavoriteOverview extends StatefulWidget {
  const FavoriteOverview({Key? key}) : super(key: key);

  @override
  State<FavoriteOverview> createState() => _FavoriteOverviewState();
}

class _FavoriteOverviewState extends State<FavoriteOverview>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Provider.of<ContactState>(context, listen: false).fetchFavoriteData();
  }

  Future<void> _refresh() async {
    Provider.of<ContactState>(context, listen: false).fetchFavoriteData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var contactState = Provider.of<ContactState>(context, listen: true);

    return contactState.listOfFavotire.isEmpty
        ? contactState.searchToggle
            ? NoDataMessage(message: 'Er is geen overeenkomst gevonden')
            : LoadingState(message: 'Favorieten ')
        : RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              itemCount: contactState.listOfFavotire.length,
              itemBuilder: (BuildContext ctxt, int index) {
                ContactUser contact = contactState.listOfFavotire[index];
                return ContactFavoriteTiles(contact, 'f');
              },
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
