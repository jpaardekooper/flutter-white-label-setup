import 'package:base/state/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:twitter_intent/twitter_intent.dart' as twitter;
import 'package:url_launcher/url_launcher.dart';

class ContactSocialmediaIcons extends StatelessWidget {
  const ContactSocialmediaIcons({Key? key}) : super(key: key);

  launchTwitterIntent(String name) async {
    final intent = twitter.FollowUserIntent(username: name);

    await launch('$intent');
  }

  Future<void> launchFacebook(String fbUrl, String fbWebUrl) async {
    try {
      bool launched = await launch(fbUrl, forceSafariVC: false);
      print("Launched Native app $launched");

      if (!launched) {
        if (!fbWebUrl.contains('http')) {
          await launch('https://' + fbWebUrl, forceSafariVC: false);
        } else {
          await launch(fbWebUrl, forceSafariVC: false);
          print("Launched browser $launched");
        }
      }
    } catch (e) {
      if (!fbWebUrl.contains('http')) {
        await launch('https://' + fbWebUrl, forceSafariVC: false);
      } else {
        await launch(fbWebUrl, forceSafariVC: false);
      }
    }
  }

  _buttonStyle() {
    return ElevatedButton.styleFrom(
      shape: CircleBorder(),
      padding: const EdgeInsets.all(10),
      primary: Colors.white,
      onPrimary: Colors.black.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ContactState>(context, listen: false);
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 23,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.selectedContactUser.linkedIn != null &&
                    state.selectedContactUser.linkedIn!.isNotEmpty
                ? ElevatedButton(
                    onPressed: () async {
                      await launchFacebook(state.selectedContactUser.linkedIn!,
                          state.selectedContactUser.linkedIn!.toLowerCase());
                    },
                    child: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Color.fromARGB(255, 0, 119, 181),
                      size: 20,
                    ),
                    style: _buttonStyle(),
                  )
                : SizedBox(
                    height: 30,
                  ),
            state.selectedContactUser.twitter != null &&
                    state.selectedContactUser.twitter!.isNotEmpty
                ? ElevatedButton(
                    onPressed: () async {
                      await launchTwitterIntent(
                          state.selectedContactUser.twitter!.toLowerCase());
                    },
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Color.fromARGB(255, 0, 119, 181),
                      size: 20,
                    ),
                    style: _buttonStyle(),
                  )
                : SizedBox.shrink(),
            state.selectedContactUser.facebook != null &&
                    state.selectedContactUser.facebook!.isNotEmpty
                ? ElevatedButton(
                    onPressed: () async {
                      await launchFacebook(state.selectedContactUser.facebook!,
                          state.selectedContactUser.facebook!.toLowerCase());
                    },
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Color.fromARGB(255, 0, 119, 181),
                      size: 20,
                    ),
                    style: _buttonStyle(),
                  )
                : SizedBox.shrink()
          ],
        ),
      ],
    );
  }
}
