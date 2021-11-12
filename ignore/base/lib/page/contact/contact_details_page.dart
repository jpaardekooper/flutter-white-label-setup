import 'package:base/models/contact_user.dart';
import 'package:base/ui/widgets/contact/contact_detail_skeleton.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
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

    return WillPopScope(
      onWillPop: () {
        provider.setEditProfileToFalse();
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
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
                  return AdvancedSliverAppBar(page: widget.page);
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
