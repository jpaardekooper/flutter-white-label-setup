import 'package:base/state/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteMenu extends StatefulWidget {
  const FavoriteMenu({Key? key}) : super(key: key);

  @override
  State<FavoriteMenu> createState() => _FavoriteMenuState();
}

class _FavoriteMenuState extends State<FavoriteMenu> {
  _toggleFavoriteText() {
    var contactState = Provider.of<ContactState>(context, listen: false);
    return contactState.selectedContactUser.isFavorite!
        ? " is toegevoegd aan favorieten"
        : " is verwijderd uit favorieten";
  }

  _showMessage() {
    var contactState = Provider.of<ContactState>(context, listen: false);
    if (ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        //   backgroundColor: Colors.red[100],
        behavior: SnackBarBehavior.floating,
        content: Text(
          contactState.selectedContactUser.firstName! + _toggleFavoriteText(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      contactState.selectedContactUser.updateIsFavorite(
                          !contactState.selectedContactUser.isFavorite!);

                      if (contactState.selectedContactUser.isFavorite!) {
                        contactState
                            .addFavorite(contactState.selectedContactUser);
                      } else {
                        contactState
                            .removeFavorite(contactState.selectedContactUser);
                        contactState.removeFavoriteLocal(
                            contactState.selectedContactUser);
                      }

                      _showMessage();
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: contactState.selectedContactUser.isFavorite!
                        ? Theme.of(context).colorScheme.primaryVariant
                        : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            contactState.selectedContactUser.isBoardMember!
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.group,
                            color:
                                Theme.of(context).colorScheme.primaryVariant),
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
