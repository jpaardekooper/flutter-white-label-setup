import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/contact/forms/contact_form_tile.dart';
import 'package:base/ui/widgets/text/subtitle_text_1.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({Key? key}) : super(key: key);

  Widget dividerToggle(BuildContext context) {
    return Divider(color: Theme.of(context).colorScheme.secondary);
  }

  Future<void> launchUrl(String? webUrl) async {
    if (webUrl == null) {
      return;
    }
    try {
      await launch(webUrl, forceSafariVC: false);
    } catch (e) {
      await launch(webUrl, forceSafariVC: false);
    }
  }

  launchEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '$email',
      query: encodeQueryParameters(<String, String>{'subject': 'Betreft:'}),
    );

    try {
      await launch(emailLaunchUri.toString(), forceSafariVC: false);
    } catch (e) {
      print('');
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContactState>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32, bottom: 32),
            child: SubtitleText1(text: 'Gebruikersinformatie'),
          ),
          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            text: provider.selectedContactUser.firstName ?? '',
          ),
          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            text: provider.selectedContactUser.insertion ?? '',
          ),
          ////////////////////

          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            text: provider.selectedContactUser.lastName ?? '',
          ),
          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            text: provider.selectedContactUser.boardMemberFunction ?? '',
          ),

          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.phone,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            trailing: IconButton(
              onPressed: () {
                launchUrl("tel:" + provider.selectedContactUser.phoneNumber!);
              },
              icon: Icon(Icons.phone_android_rounded),
            ),
            text: provider.selectedContactUser.phoneNumber ?? '',
          ),

          ContactFormTile(
            leading: Icon(
              Icons.web,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            text: provider.selectedContactUser.description ?? '',
          ),
          dividerToggle(context),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16, bottom: 32),
            child: SubtitleText1(text: 'Bedrijfsgegevens'),
          ),

          ContactFormTile(
            leading: Icon(
              Icons.mail,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            text: provider.selectedContactUser.description ?? '',
          ),

          ContactFormTile(
            text: provider.selectedContactUser.companyName ?? '',
          ),
          ContactFormTile(
            text: provider.selectedContactUser.address ?? '',
          ),
          ContactFormTile(
            text: provider.selectedContactUser.zipcode ?? '',
          ),

          ContactFormTile(
            text: provider.selectedContactUser.city ?? '',
          ),

          dividerToggle(context),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32, bottom: 32),
            child: SubtitleText1(text: 'Social Media'),
          ),

          ContactFormTile(
            leading: Icon(
              Icons.web,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
            trailing: IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: () {
                launchUrl(provider.selectedContactUser.website);
              },
            ),
            text: provider.selectedContactUser.website ?? '',
          ),
        ],
      ),
    );
  }
}
