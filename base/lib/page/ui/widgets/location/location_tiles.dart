import 'package:base/models/spotted_location.dart';
import 'package:base/page/location/location_form_view.dart';
import 'package:base/page/ui/widgets/components/dissmissble_page.dart';
import 'package:base/page/ui/widgets/text/text_with_shadow.dart';
import 'package:base/state/location_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LocationTiles extends StatelessWidget {
  LocationTiles(this.location);
  final SpottedLocation location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 8),
      minVerticalPadding: 0,
      onTap: () async {
        Provider.of<LocationState>(context, listen: false)
            .setselectedLocation(location);

        await Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: DissmissibleAppPage(child: LocationFormView()),
            ctx: context,
          ),
        );

        Provider.of<LocationState>(context, listen: false).fetchLocationData();
      },
      // Renders a `Material` in its build method
      title: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: CachedNetworkImageProvider(
            location.visualImage == null ||
                    location.visualImage!.isEmpty ||
                    !location.visualImage!.contains('www')
                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s'
                : location.visualImage!,
          ),
          fit: BoxFit.cover,
        )),
        //  fit:
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithShadow(
                  text: location.title ?? '',
                  size: 18,
                  alignment: Alignment.topLeft,
                ),
                TextWithShadow(
                  text: location.title ?? '',
                  size: 21,
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
