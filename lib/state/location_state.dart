import 'dart:convert';

import 'package:base/helper/shared_preference.dart';
import 'package:base/models/spotted_location.dart';
import 'package:base/repository/controller/location_controller.dart';
import 'package:base/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart' as _;

class LocationState with ChangeNotifier {
  LocationState(this.localStorage, this.authState);

  final LocalStorage localStorage;
  final AuthState authState;

  final LocationController _eventController = LocationController();

  bool get editStatus => _editStatus;

  List<SpottedLocation> get locationList => _locationList;

  SpottedLocation get selectedLocation => _selectedLocation;

  List<SpottedLocation> get searchList => _searchList;

  List<SpottedLocation> _searchList = [];

  bool _editStatus = false;

  List<SpottedLocation> _locationList = [];

  late SpottedLocation _selectedLocation;

  late bool _serviceEnabled = false;

  bool get serviceEnabled => _serviceEnabled;

  _.Location location = _.Location();

  late _.PermissionStatus _permissionGranted;

  _.PermissionStatus get permissionSatus => _permissionGranted;

  _.LocationData? locationData;

  locationPermission() async {
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == _.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != _.PermissionStatus.granted) {
        return;
      } else {
        location.onLocationChanged.listen((_.LocationData currentLocation) {
          locationData = currentLocation;
          _serviceEnabled = true;
        });
      }
    }

    notifyListeners();
  }

  Future<List<SpottedLocation>?> fetchLocationData() async {
    try {
      if (await authState.refreshSession()) {
        Response result = await _eventController
            .fetchLocations(authState.token.accessToken!.bearerToken!);

        if (result.statusCode == 200) {
          List<dynamic> parsed = json.decode(result.body) as List;
          _locationList =
              parsed.map((val) => SpottedLocation.fromJson(val)).toList();
        }
        notifyListeners();
        return _locationList;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  Future<dynamic> fetchSelectedLocationData(SpottedLocation location) async {
    try {
      _selectedLocation = location;

      //    notifyListeners();
    } on Exception catch (_) {
      return _.toString();
    }
  }

  changeEditState() {
    _editStatus = !_editStatus;

    notifyListeners();
  }

  void filterSearchResults(String query) async {
    List<SpottedLocation> dummySearchList = [];
    dummySearchList.addAll(_locationList);
    if (query.isNotEmpty) {
      List<SpottedLocation> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.title != null &&
            item.title!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      _searchList.clear();
      _searchList.addAll(dummyListData);

      notifyListeners();
    } else {
      _searchList.clear();
      _searchList.addAll(_locationList);

      notifyListeners();
    }
  }

  changeLatitudeLongitude(LatLng location) {
    _selectedLocation.latitude = location.latitude;
    _selectedLocation.longitude = location.longitude;

    notifyListeners();
  }

  resetSearch() async {
    _searchList.clear();
    _searchList.addAll(_locationList);
    notifyListeners();
  }
}
