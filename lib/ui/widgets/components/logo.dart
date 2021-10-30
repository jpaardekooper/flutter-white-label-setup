import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.scale}) : super(key: key);
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      FlavorAssets.logo,
      scale: FlavorAssets.scale,
      height: 50,
    );
  }
}
