import 'package:base/models/contact_user.dart';
import 'package:base/page/contact/contact_details_page.dart';
import 'package:base/ui/widgets/components/dissmissble_page.dart';
import 'package:base/ui/widgets/contact/ui/cached_image.dart';
import 'package:config/contact/contact_styling_theme.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ContactTiles extends StatefulWidget {
  ContactTiles(this.contact, this.page);
  final ContactUser contact;
  final String page;

  @override
  _ContactTilesState createState() => _ContactTilesState();
}

class _ContactTilesState extends State<ContactTiles> {
  _toggleFavoriteText() {
    return widget.contact.isFavorite!
        ? " is toegevoegd aan favorieten"
        : " is verwijderd uit favorieten";
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
          widget.contact.firstName! + _toggleFavoriteText(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: CachedImage(
          id: widget.contact.id.toString(),
          url: widget.contact.profilePicture ?? '',
          width: 40.0,
          height: 40.0,
          page: widget.page,
        ),
      ),
      title: ContactTileHeading(
        text: contactState.test.fullName(
          widget.contact.firstName,
          widget.contact.insertion,
          widget.contact.lastName,
        ),
      ),
      selectedTileColor: Theme.of(context).colorScheme.primary,
      subtitle: ContactTileBody(
        text: widget.contact.companyName ?? '',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.contact.isBoardMember!
              ? Icon(
                  Icons.groups,
                  size: 18,
                  color: widget.contact.isFavorite!
                      ? Theme.of(context).colorScheme.primaryVariant
                      : Theme.of(context).colorScheme.secondary,
                )
              : Container(),
          IconButton(
            onPressed: () {
              setState(() {
                widget.contact.updateIsFavorite(!widget.contact.isFavorite!);

                if (widget.contact.isFavorite!) {
                  contactState.addFavorite(widget.contact);
                } else {
                  contactState.removeFavorite(widget.contact);
                  contactState.removeFavoriteLocal(widget.contact);
                }
              });

              _showMessage();
            },
            splashRadius: 18,
            icon: Icon(
              Icons.star,
              size: 18,
              color: widget.contact.isFavorite!
                  ? Theme.of(context).colorScheme.primaryVariant
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();

        contactState.disposeSearch();
        contactState.setContactId(widget.contact.id!);

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: DissmissibleAppPage(child: ContactDetails(widget.page)),
          ),
        );
      },
    );
  }
}
