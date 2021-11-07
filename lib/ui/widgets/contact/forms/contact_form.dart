import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/contact/forms/contact_form_tile.dart';
import 'package:base/ui/widgets/text/subtitle_text_1.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: SubtitleText1(subtitle: 'Gebruikersinformatie'),
          ),
          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.prescription,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            text: provider.selectedContactUser.firstName ?? '',
          ),
          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            text: provider.selectedContactUser.insertion ?? '',
          ),
          ////////////////////

          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            text: provider.selectedContactUser.lastName ?? '',
          ),
          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            text: provider.selectedContactUser.boardMemberFunction ?? '',
          ),

          ContactFormTile(
            leading: FaIcon(
              FontAwesomeIcons.phone,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            trailing: IconButton(
              onPressed: () {
                launchUrl("tel:" + provider.selectedContactUser.phoneNumber!);
              },
              icon: Icon(Icons.phone_android_rounded),
            ),
            text: provider.selectedContactUser.phoneNumber ?? '',
          ),

          dividerToggle(context),

          ContactFormTile(
            leading: Icon(
              Icons.web,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            text: provider.selectedContactUser.description ?? '',
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SubtitleText1(subtitle: 'Bedrijfsgegevens'),
          ),

          ContactFormTile(
            leading: Icon(
              Icons.mail,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
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
            padding: EdgeInsets.all(16.0),
            child: SubtitleText1(subtitle: 'Social Media'),
          ),

          ContactFormTile(
            leading: Icon(
              Icons.web,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
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
