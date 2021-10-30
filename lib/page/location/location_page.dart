import 'package:base/models/location_model.dart';
import 'package:base/state/location_state.dart';
import 'package:base/ui/widgets/components/logo.dart';
import 'package:base/ui/widgets/location/location_search.dart';
import 'package:base/ui/widgets/location/location_tiles.dart';
import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';
import 'package:base/state/auth_state.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    // Provider.of<LocationState>(context, listen: false).fetchLocationData(
    //     Provider.of<AuthState>(context, listen: false).user.accessToken!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<LocationState>(context, listen: true);
    var _authState = Provider.of<AuthState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Logo(scale: FlavorAssets.scale),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: LocationSearch(),
            ),
            _state.locationList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Aanbevolen locaties worden ingeladen'),
                        CircularProgressIndicator()
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _state.searchList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Location _location = _state.searchList[index];
                        return LocationTiles(_location);
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: _authState.appUser.isAdmin!
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Colors.white,
              onPressed: () {},
            )
          : null,
    );
  }
}
