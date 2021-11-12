import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      FlavorAssets.logo,
      scale: FlavorAssets.logoScale,
      //   height: 50 * FlavorAssets.logoScale,
    );
  }
}

class AppbarLogo extends StatelessWidget {
  const AppbarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      FlavorAssets.logo,
      scale: FlavorAssets.appbarLogoScale,
      height: 60 * FlavorAssets.appbarLogoScale,
    );
  }
}
