import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/contact/forms/contactform_validation_field.dart';
import 'package:base/ui/widgets/text/subtitle_text_1.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ContactEditForm extends StatefulWidget {
  ContactEditForm({Key? key}) : super(key: key);

  @override
  State<ContactEditForm> createState() => _ContactEditFormState();
}

class _ContactEditFormState extends State<ContactEditForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContactState>(context, listen: true);
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SubtitleText1(subtitle: 'Gebruikersinformatie'),
          ),
          ContactFormField(
            leading: FaIcon(
              FontAwesomeIcons.prescription,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.firstName,
            hint: 'Roep naam',
            type: ContactFormValidation.notempty,
            function: provider.selectedContactUser.updateFirstname,
          ),
          ContactFormField(
            leading: FaIcon(
              FontAwesomeIcons.prescription,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.insertion,
            hint: 'Tussenvoegsel',
            type: ContactFormValidation.text,
            function: provider.selectedContactUser.updateInsertion,
          ),
          ContactFormField(
            leading: FaIcon(
              FontAwesomeIcons.prescription,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.lastName,
            hint: 'Tussenvoegsel',
            type: ContactFormValidation.notempty,
            function: provider.selectedContactUser.updateLastname,
          ),
          ContactFormField(
            leading: FaIcon(
              FontAwesomeIcons.businessTime,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.boardMemberFunction,
            hint: 'functie',
            type: ContactFormValidation.text,
            function: provider.selectedContactUser.updateBoardmemberFunction,
          ),
          ContactFormField(
            leading: FaIcon(
              FontAwesomeIcons.phone,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.phoneNumber,
            hint: 'Telefoonnummer',
            type: ContactFormValidation.phone,
            function: provider.selectedContactUser.updatePhonenumber,
          ),
          ContactFormField(
            leading: Icon(
              Icons.mail,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.emailAddress,
            hint: 'Email',
            type: ContactFormValidation.email,
            function: provider.selectedContactUser.updateEmail,
          ),
          ContactFormField(
            leading: Icon(
              Icons.web,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.description,
            hint: 'Bibliografie',
            type: ContactFormValidation.discription,
            function: provider.selectedContactUser.updateDescription,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SubtitleText1(subtitle: 'Bedrijfsgegevens'),
          ),
          Column(
            children: [
              ContactFormField(
                leading: Icon(
                  Icons.mail,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 16,
                ),
                value: provider.selectedContactUser.companyName,
                hint: 'Bedrijfsnaam',
                type: ContactFormValidation.text,
                function: provider.selectedContactUser.updateCompanyname,
              ),
              ContactFormField(
                leading: SizedBox.shrink(),
                value: provider.selectedContactUser.address,
                hint: 'Adres',
                type: ContactFormValidation.text,
                function: provider.selectedContactUser.updateAddress,
              ),
              ContactFormField(
                leading: SizedBox.shrink(),
                value: provider.selectedContactUser.zipcode,
                hint: 'Postcode',
                type: ContactFormValidation.text,
                function: provider.selectedContactUser.updateZipcode,
              ),
              ContactFormField(
                leading: SizedBox.shrink(),
                value: provider.selectedContactUser.city,
                hint: 'Plaats',
                type: ContactFormValidation.text,
                function: provider.selectedContactUser.updateCity,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SubtitleText1(subtitle: 'Social Media'),
          ),
          ContactFormField(
            leading: Icon(
              Icons.web,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.website ?? '',
            hint: 'Website',
            type: ContactFormValidation.url,
            function: provider.selectedContactUser.updateWebsite,
          ),
          ContactFormField(
            leading: Icon(
              FontAwesomeIcons.linkedin,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.linkedIn ?? '',
            hint: 'LinkedIn url',
            type: ContactFormValidation.linkedIn,
            function: provider.selectedContactUser.updateLinkedIn,
          ),
          ContactFormField(
            leading: Icon(
              FontAwesomeIcons.twitter,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.twitter,
            hint: 'Twitter profielnaam',
            type: ContactFormValidation.twitter,
            function: provider.selectedContactUser.updateTwitter,
          ),
          ContactFormField(
            leading: Icon(
              FontAwesomeIcons.facebook,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
            value: provider.selectedContactUser.facebook,
            hint: 'Facebook url',
            type: ContactFormValidation.facebook,
            function: provider.selectedContactUser.updateFacebook,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () async {
                    formKey.currentState!.save();
                    FocusScope.of(context).unfocus();
                    if (!formKey.currentState!.validate()) return;

                    bool value = await provider.saveProfileData();

                    if (value) {
                      Provider.of<ContactState>(context, listen: false)
                          .fetchContactData();

                      Provider.of<ContactState>(context, listen: false)
                          .toggleEditProfile();
                    } else {}
                  },
                  child: Text('Opslaan'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
