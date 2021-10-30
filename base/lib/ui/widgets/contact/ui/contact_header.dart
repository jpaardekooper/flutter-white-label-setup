import 'package:base/ui/widgets/contact/ui/blurred_background.dart';
import 'package:base/ui/widgets/contact/ui/contact_socialmedia_icons.dart';
import 'package:base/ui/widgets/contact/ui/favorite_menu.dart';
import 'package:base/ui/widgets/contact/ui/profile_image_name_company.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  final String page;
  const Header(this.maxHeight, this.minHeight, this.page);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      child: Stack(
        children: [
          _buildGradient(),
          _buildFavoriteMenu(),
          _buildProfileImageAndTitle(),
          _buildSocialMediaIcons(),
        ],
      ),
    );
  }

  _buildSocialMediaIcons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ContactSocialmediaIcons(),
    );
  }

  _buildProfileImageAndTitle() {
    return ProfileImageNameCompany(page: page);
  }

  _buildFavoriteMenu() {
    return FavoriteMenu();
  }

  _buildGradient() {
    return BlurredBackground();
  }
}
