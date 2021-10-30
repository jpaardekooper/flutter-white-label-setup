import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/contact/ui/profile_image.dart';
import 'package:base/ui/widgets/text/text_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileImageNameCompany extends StatelessWidget {
  const ProfileImageNameCompany({Key? key, required this.page})
      : super(key: key);
  final String page;

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImage(1, page, 180),
        SizedBox(
          height: 10,
        ),
        TextWithShadow(
            text: (contactState.selectedContactUser.firstName ?? '') +
                " " +
                (contactState.selectedContactUser.insertion ?? '') +
                " " +
                (contactState.selectedContactUser.lastName ?? ''),
            size: 18),
        TextWithShadow(
            text: contactState.selectedContactUser.companyName ?? '', size: 18),
      ],
    );
  }
}
