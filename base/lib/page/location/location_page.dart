// ignore_for_file: lines_longer_than_80_chars

import 'package:base/models/spotted_location.dart';
import 'package:base/page/ui/widgets/empty_state.dart';
import 'package:base/page/ui/widgets/location/location_tiles.dart';
import 'package:base/state/location_state.dart';
import 'package:base/page/ui/widgets/components/logo.dart';
import 'package:base/page/ui/widgets/location/location_search.dart';
import 'package:base/page/ui/widgets/text/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<LocationState>(context, listen: false).fetchLocationData();
  }

  @override
  Widget build(BuildContext context) {
    var locationState = Provider.of<LocationState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppbarLogo(),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Een nieuwe locatie toevoegen',
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(color: Colors.white, child: LocationSearch()),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: locationState.locationList.isEmpty
                  ? EmptyState(message: 'Geen locaties gevonden')
                  : RefreshIndicator(
                      onRefresh: locationState.fetchLocationData,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        shrinkWrap: false,
                        itemExtent: 250,
                        itemCount: locationState.locationList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          SpottedLocation _location =
                              locationState.locationList[index];
                          return LocationTiles(_location);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );

    //   Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
    //           child: LocationSearch(),
    //         ),
    //         _state.locationList.isEmpty
    //             ? Center(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text('Aanbevolen locaties worden ingeladen'),
    //                     CircularProgressIndicator()
    //                   ],
    //                 ),
    //               )
    //             : Expanded(
    //                 child: ListView.builder(
    //                   physics: const AlwaysScrollableScrollPhysics(),
    //                   shrinkWrap: true,
    //                   itemCount: _state.searchList.length,
    //                   itemBuilder: (BuildContext ctxt, int index) {
    //                     Location _location = _state.searchList[index];
    //                     return LocationTiles(_location);
    //                   },
    //                 ),
    //               ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: _authState.appUser.isAdmin!
    //       ? FloatingActionButton(
    //           child: Icon(
    //             Icons.add,
    //             color: Theme.of(context).colorScheme.primary,
    //           ),
    //           backgroundColor: Colors.white,
    //           onPressed: () {},
    //         )
    //       : null,
    // );
  }
}
