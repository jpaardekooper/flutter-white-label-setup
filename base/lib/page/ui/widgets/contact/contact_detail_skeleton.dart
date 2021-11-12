import 'package:base/page/ui/widgets/components/buttons/contact_back_button.dart';
import 'package:base/state/contact_state.dart';
import 'package:base/page/ui/widgets/components/buttons/toggle_edit_contact.dart';
import 'package:base/page/ui/widgets/components/logo.dart';
import 'package:base/page/ui/widgets/contact/forms/contact_form_view.dart';
import 'package:base/page/ui/widgets/contact/ui/blurred_background.dart';
import 'package:base/page/ui/widgets/contact/ui/contact_socialmedia_icons.dart';
import 'package:base/page/ui/widgets/contact/ui/favorite_menu.dart';
import 'package:base/page/ui/widgets/contact/ui/profile_image.dart';
import 'package:base/page/ui/widgets/text/text_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancedSliverAppBar extends StatelessWidget {
  const AdvancedSliverAppBar({required this.page});

  final double expandedHeight = 400;

  final String page;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ContactBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: AppbarLogo(),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          ToggleEditContact(),
        ],
      ),
      body: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: false,
                delegate: CustomSliverAppBarDelegate(
                    page: page,
                    expandedHeight: MediaQuery.of(context).size.height / 2),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                SliverToBoxAdapter(
                  child: ContactFormView(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
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
  double get minExtent => kToolbarHeight + 50;

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var contactState = Provider.of<ContactState>(context, listen: true);

    var size = 50;
    var top = expandedHeight - shrinkOffset - size / 2;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: top > 0 ? top : 0,
          child: buildBackground(shrinkOffset),
        ),
        Positioned(
          top: top * 0.73,
          left: 20,
          right: 20,
          child: buildName(shrinkOffset, context),
        ),
        Positioned(
          top: top * 0.81,
          left: 20,
          right: 20,
          child: buildCompany(shrinkOffset, context),
        ),
        Positioned(
          top: top / 4,
          left: 20,
          right: 20,
          child: buildAvatar(shrinkOffset),
        ),
        //   buildFavoriteMenu(shrinkOffset),

        Positioned(
          top: top / 3,
          right: 10,
          child: buildFavoriteMenu(shrinkOffset),
        ),
        //linkedIn
        Positioned(
          top: top - 20,
          left: width / 2 - 70,
          child: ContactSocialmediaIcons(
            buttonType: SocialMediaButton.linkedIn,
            buttonEnabled: contactState.selectedContactUser.linkedIn != null &&
                contactState.selectedContactUser.linkedIn!.isNotEmpty,
          ),
        ),

        Positioned(
          top: top - 20,
          left: MediaQuery.of(context).size.width / 2 - 20,
          right: MediaQuery.of(context).size.width / 2 - 20,
          child: ContactSocialmediaIcons(
            buttonType: SocialMediaButton.twitter,
            buttonEnabled: contactState.selectedContactUser.twitter != null &&
                contactState.selectedContactUser.twitter!.isNotEmpty,
          ),
        ),
        Positioned(
          top: top - 20,
          right: width / 2 - 70,
          child: ContactSocialmediaIcons(
            buttonType: SocialMediaButton.facebook,
            buttonEnabled: contactState.selectedContactUser.twitter != null &&
                contactState.selectedContactUser.twitter!.isNotEmpty,
          ),
        ),
      ],
    );
  }

  Widget buildBackground(double shrinkOffset) => BlurredBackground();

  Widget buildAvatar(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset) < 0.4 ? 0 : 1,
        child: ProfileImage(
          page: page,
          size: expandedHeight / 2.5 * disappear(shrinkOffset),
        ),
      );

  Widget buildName(double shrinkOffset, BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);

    return Opacity(
      opacity: disappear(shrinkOffset) < 0.85 ? 0 : 1,
      child: TextWithShadow(
        alignment: Alignment.center,
        text: contactState.selectedContactUser.fullName ?? '',
        size: 16 * disappear(shrinkOffset),
      ),
    );
  }

  Widget buildFavoriteMenu(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset) < 0.8 ? 0 : 1,
        child: FavoriteMenu(),
      );

  Widget buildCompany(double shrinkOffset, BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return Opacity(
      opacity: disappear(shrinkOffset) < 0.85 ? 0 : 1,
      child: TextWithShadow(
        alignment: Alignment.center,
        text: contactState.selectedContactUser.companyName ?? '',
        size: 16 * disappear(shrinkOffset),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
