import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/components/buttons/toggle_edit_contact.dart';
import 'package:base/ui/widgets/contact/forms/contact_form_view.dart';
import 'package:base/ui/widgets/contact/ui/blurred_background.dart';
import 'package:base/ui/widgets/contact/ui/contact_appbar.dart';
import 'package:base/ui/widgets/contact/ui/contact_socialmedia_icons.dart';
import 'package:base/ui/widgets/contact/ui/favorite_menu.dart';
import 'package:base/ui/widgets/contact/ui/profile_image.dart';
import 'package:base/ui/widgets/text/text_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancedSliverAppBar extends StatelessWidget {
  const AdvancedSliverAppBar({required this.page});

  final String page;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate:
                    CustomSliverAppBarDelegate(expandedHeight: 400, page: page),
                pinned: true,
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SingleChildScrollView(
                      child: ContactFormView(),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // =>

  //  Scaffold(
  //       body: CustomScrollView(
  //         slivers: [
  //           SliverPersistentHeader(
  //             delegate:
  //                 CustomSliverAppBarDelegate(expandedHeight: 400, page: page),
  //             pinned: false,
  //           ),
  //           SliverList(
  //             delegate: SliverChildListDelegate(
  //               [SingleChildScrollView(child: ContactFormView())],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String page;
  final double expandedHeight;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.page,
  });

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 60;

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 50;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: top > 0 ? top : 0,
          child: buildBackground(shrinkOffset),
        ),
        buildAppBar(shrinkOffset),
        buildAvatar(shrinkOffset),
        buildFavoriteMenu(shrinkOffset),
        buildName(shrinkOffset, context, top),
        buildCompany(shrinkOffset, context, top),
        buildEditButton(shrinkOffset),
        Positioned(
          top: top - 25,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset) < 0.4 ? 0 : 1,
        child: BlurredBackground(),
      );

  Widget buildAvatar(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset) < 0.4 ? 0 : 1,
        child: ProfileImage(page: page, size: 170 * disappear(shrinkOffset)),
      );

  Widget buildName(double shrinkOffset, BuildContext context, double top) {
    var contactState = Provider.of<ContactState>(context, listen: true);

    return Positioned.fill(
      top: top / 2 + 20,
      child: Opacity(
        opacity: disappear(shrinkOffset) < 0.7 ? 0 : 1,
        child: Center(
          child: TextWithShadow(
              text: contactState.selectedContactUser.fullName ?? '',
              size: 18 * disappear(shrinkOffset)),
        ),
      ),
    );
  }

  Widget buildFavoriteMenu(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset) < 0.8 ? 0 : 1,
        child: FavoriteMenu(),
      );

  Widget buildCompany(double shrinkOffset, BuildContext context, double top) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return Positioned.fill(
      top: top / 2 + 70,
      child: Opacity(
        opacity: disappear(shrinkOffset) < 0.7 ? 0 : 1,
        child: Center(
          child: TextWithShadow(
              text: contactState.selectedContactUser.companyName ?? '',
              size: 18 * disappear(shrinkOffset)),
        ),
      ),
    );
  }

  Widget buildEditButton(double shrinkOffset) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Opacity(
          opacity: disappear(shrinkOffset) < 0.4 ? 0 : 1,
          child: ToggleEditContact(),
        ),
      ),
    );
  }

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset) < 0.6 ? 0 : 1,
        child: ContactSocialmediaIcons(),
      );

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset) < 0.6 ? 0 : 1,
        child: ContactAppBar(),
      );

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
