import 'package:base/state/auth_state.dart';
import 'package:base/state/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleEditContact extends StatefulWidget {
  const ToggleEditContact({Key? key}) : super(key: key);
  //final Function function;

  @override
  _ToggleEditContactState createState() => _ToggleEditContactState();
}

class _ToggleEditContactState extends State<ToggleEditContact> {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context, listen: false);

    var contactState = Provider.of<ContactState>(context, listen: true);
    return authState.appUser.isAdmin! ||
            contactState.selectedContactUser.id == authState.appUser.id
        ? Material(
            color: Colors.transparent,
            child: InkWell(
              child: IconButton(
                splashRadius: Material.defaultSplashRadius / 2,
                splashColor: Colors.white.withOpacity(0.5),
                onPressed: () =>
                    //      widget.function();
                    contactState.toggleEditProfile(),
                icon: Icon(
                  contactState.editProfileToggle ? Icons.close : Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container();
  }
}
