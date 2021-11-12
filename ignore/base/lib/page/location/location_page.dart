// ignore_for_file: lines_longer_than_80_chars

import 'package:base/models/spotted_location.dart';
import 'package:base/state/location_state.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:base/ui/widgets/location/location_search.dart';
import 'package:base/ui/widgets/text/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Future<List<SpottedLocation?>?> data;

  @override
  void initState() {
    super.initState();

    data =
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
      body: RefreshIndicator(
        onRefresh: locationState.fetchLocationData,
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            shrinkWrap: false,
            children: [
              LocationSearch(),
              FutureBuilder<List<SpottedLocation?>?>(
                future: data,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 100,
                        ),
                        child: Center(
                          child: LoadingState(
                              message: 'Locaties worden opgehaald'),
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError || snapshot.data == null) {
                        return Container(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - 100,
                            ),
                            child: Center(
                              child: Text('Er zijn nog geen locaties gevonden'),
                            ));
                      } else {
                        //als alles goed gaat
                        //  return AdvancedSliverAppBar(page: widget.page);
                        return Container();
                        // ListView(
                        //   shrinkWrap: true,
                        //   physics: const ClampingScrollPhysics(),
                        //   children: [
                        //     Header(
                        //       maxHeight,
                        //       minHeight,
                        //       widget.page,
                        //     ),
                        //     ContactFormView()
                        //   ],
                        // );
                      }

                    default:
                      return Container();
                  }
                },
              ),
            ],
          );
        }),
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
