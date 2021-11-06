import 'package:base/models/spotted_location.dart';
import 'package:base/page/location/location_detail.dart';
import 'package:flutter/material.dart';

class LocationTiles extends StatelessWidget {
  LocationTiles(this.location);
  final SpottedLocation location;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: location.url!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Ink.image(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s'),
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              // Navigator.push(
              //     context, createRouteTransistion(LocationDetail(location)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.title.toString(),
                      style: Theme.of(context).textTheme.headline1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
