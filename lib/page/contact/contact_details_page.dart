import 'package:base/models/contact_user.dart';
import 'package:base/ui/widgets/components/buttons/contact_back_button.dart';
import 'package:base/ui/widgets/components/buttons/toggle_edit_contact.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:base/ui/widgets/contact/forms/contact_form_view.dart';
import 'package:base/ui/widgets/contact/ui/contact_header.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails(this.page);

  final String page;

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  double get maxHeight => 300 + MediaQuery.of(context).padding.top;

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<ContactUser?> checkUser;

  @override
  void initState() {
    super.initState();

    checkUser =
        Provider.of<ContactState>(context, listen: false).fetchSelectedUser();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContactState>(context, listen: false);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        provider.setEditProfileToFalse();

        Navigator.of(context).pop();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Logo(scale: FlavorAssets.scale),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: ContactBackButton(
            function: provider.setEditProfileToFalse,
          ),
          actions: [
            ToggleEditContact(
              function: provider.toggleEditProfile,
            )
          ],
        ),
        body: FutureBuilder<ContactUser?>(
          future: checkUser,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return LoadingState(message: 'Gebruiker informatie');
              case ConnectionState.done:
                if (snapshot.hasError || snapshot.data == null) {
                  return Center(
                    child: Text('Er is iets foutgegaan bij het ophalen'),
                  );
                } else {
                  //als alles goed gaat
                  return ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Header(
                        maxHeight,
                        minHeight,
                        widget.page,
                      ),
                      ContactFormView()
                    ],
                  );
                }

              default:
                return LoadingState(message: 'Gebruiker informatie');
            }
          },
        ),
      ),
    );
  }
}
