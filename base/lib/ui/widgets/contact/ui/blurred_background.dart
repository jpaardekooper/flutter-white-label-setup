import 'dart:ui';

import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/contact/ui/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ContactState>(context, listen: false);

    return ClipRect(
      child: Stack(
        children: [
          state.selectedContactUser.profilePicture != null &&
                  Uri.parse(state.selectedContactUser.profilePicture!)
                      .isAbsolute
              ? CachedImage(
                  id: state.selectedContactUser.id.toString(),
                  url: state.selectedContactUser.profilePicture!,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  page: 'p')
              : Container(
                  color: Theme.of(context).colorScheme.primary,
                ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
