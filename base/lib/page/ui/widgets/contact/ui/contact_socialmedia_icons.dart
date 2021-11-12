import 'package:base/state/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:twitter_intent/twitter_intent.dart' as twitter;
import 'package:url_launcher/url_launcher.dart';

enum SocialMediaButton { linkedIn, twitter, facebook }

class ContactSocialmediaIcons extends StatelessWidget {
  const ContactSocialmediaIcons(
      {Key? key, required this.buttonType, required this.buttonEnabled})
      : super(key: key);
  final SocialMediaButton buttonType;
  final bool buttonEnabled;

  launchTwitterIntent(String name) async {
    var intent = twitter.FollowUserIntent(username: name);

    await launch('$intent');
  }

  Future<void> launchFacebook(String fbUrl) async {
    try {
      bool launched = await launch(fbUrl, forceSafariVC: false);
      // print("Launched Native app $launched");

      if (!launched) {
        if (!fbUrl.contains('http')) {
          await launch('https://' + fbUrl, forceSafariVC: false);
        } else {
          await launch(fbUrl, forceSafariVC: false);
          //   print("Launched browser $launched");
        }
      }
    } catch (e) {
      if (!fbUrl.contains('http')) {
        await launch('https://' + fbUrl, forceSafariVC: false);
      } else {
        await launch(fbUrl, forceSafariVC: false);
      }
    }
  }

  Icon buttonIcon() {
    switch (buttonType) {
      case SocialMediaButton.facebook:
        return const Icon(
          FontAwesomeIcons.facebookF,
          color: Color.fromARGB(255, 0, 119, 181),
          size: 16,
        );

      case SocialMediaButton.twitter:
        return const Icon(
          FontAwesomeIcons.twitter,
          color: Color.fromARGB(255, 0, 119, 181),
          size: 16,
        );

      case SocialMediaButton.linkedIn:
        return const Icon(
          FontAwesomeIcons.linkedinIn,
          color: Color.fromARGB(255, 0, 119, 181),
          size: 16,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ContactState>(context, listen: true);

    return buttonEnabled
        ? Material(
            color: Colors.transparent,
            elevation: 2,
            shape: CircleBorder(),
            child: Ink(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ), // LinearGradientBoxDecoration
              child: InkWell(
                onTap: () {
                  switch (buttonType) {
                    case SocialMediaButton.facebook:
                      launchFacebook(state.selectedContactUser.facebook!);
                      break;
                    case SocialMediaButton.twitter:
                      launchTwitterIntent(state.selectedContactUser.twitter!);
                      break;
                    case SocialMediaButton.linkedIn:
                      launchFacebook(state.selectedContactUser.linkedIn!);
                      break;
                  }
                },
                customBorder: CircleBorder(),
                child: Center(
                  child: buttonIcon(),
                ),
                splashColor: Colors.blue.shade100,
              ), // Red will correctly spread over gradient
            ),
          )
        : SizedBox.shrink();
  }
}
