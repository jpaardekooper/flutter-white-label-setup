import 'package:base/state/app_editing_state.dart';
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
    var appEditState = Provider.of<AppEditingState>(context);

    var contactState = Provider.of<ContactState>(context);
    return contactState.test.appUser.isAdmin! ||
            contactState.selectedContactUser.id == contactState.test.appUser.id
        ? Material(
            color: Colors.transparent,
            child: InkWell(
              child: IconButton(
                splashRadius: 60,
                onPressed: () =>
                    Provider.of<AppEditingState>(context, listen: false)
                        .toggleEdit(),
                icon: Icon(
                  appEditState.EditStatus ? Icons.close : Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Container();
  }
}
