import 'package:base/ui/widgets/contact/ui/profile_image.dart';
import 'package:flutter/material.dart';

class ProfileImageNameCompany extends StatelessWidget {
  const ProfileImageNameCompany({Key? key, required this.page})
      : super(key: key);

  final String page;

  @override
  Widget build(BuildContext context) {
    return ProfileImage(page: page, size: 160);
  }
}
