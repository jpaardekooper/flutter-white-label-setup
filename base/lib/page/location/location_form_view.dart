import 'package:base/page/ui/widgets/components/logo.dart';
import 'package:flutter/material.dart';

class LocationFormView extends StatelessWidget {
  const LocationFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: AppbarLogo(),
        centerTitle: true,
      ),
    );
  }
}
