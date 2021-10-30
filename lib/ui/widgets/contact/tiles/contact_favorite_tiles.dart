import 'package:base/models/contact_user.dart';
import 'package:base/page/contact/contact_details_page.dart';
import 'package:base/ui/widgets/contact/ui/cached_image.dart';
import 'package:base/util/page_route.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';

import 'package:provider/provider.dart';

class ContactFavoriteTiles extends StatefulWidget {
  ContactFavoriteTiles(this.contact, this.page);
  final ContactUser contact;
  final String page;

  @override
  _ContactFavoriteTilesState createState() => _ContactFavoriteTilesState();
}

class _ContactFavoriteTilesState extends State<ContactFavoriteTiles> {
  bool _favorite = true;

  void toggleFavorite() {
    setState(() {
      Provider.of<ContactState>(context, listen: false)
          .removeFavoriteLocal(widget.contact);

      Provider.of<ContactState>(context, listen: false)
          .removeFavorite(widget.contact);
    });

    _showMessage();
  }

  _showMessage() {
    if (ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        //   backgroundColor: Colors.red[100],
        behavior: SnackBarBehavior.floating,
        content: Text(
          widget.contact.firstName! + " is verwijderd uit favorieten",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContactState>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: CachedImage(
            id: widget.contact.id.toString(),
            url: widget.contact.profilePicture ?? '',
            width: 40.0,
            height: 40.0,
            page: widget.page),
      ),
      title: Text(
        Provider.of<ContactState>(context, listen: true).test.fullName(
            widget.contact.firstName,
            widget.contact.insertion,
            widget.contact.lastName),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      selectedTileColor: Theme.of(context).colorScheme.primary,
      subtitle: Text(
        widget.contact.companyName ?? '',
        overflow: TextOverflow.clip,
        style: TextStyle(color: Theme.of(context).colorScheme.primaryVariant),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.contact.isBoardMember!
              ? Icon(Icons.groups,
                  color: _favorite
                      ? Theme.of(context).colorScheme.primaryVariant
                      : Theme.of(context).colorScheme.secondary)
              : Container(),
          IconButton(
            onPressed: toggleFavorite,
            splashRadius: 15,
            icon: Icon(Icons.star,
                color: _favorite
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
      onTap: () async {
        FocusScope.of(context).unfocus();

        provider.disposeSearch();
        provider.setContactId(widget.contact.id!);
        await Navigator.push(
            context, createRouteTransistion(ContactDetails(widget.page)));
      },
    );
  }
}
