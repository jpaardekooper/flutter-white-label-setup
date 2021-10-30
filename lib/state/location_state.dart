import 'package:base/helper/shared_preference.dart';
import 'package:base/models/location_model.dart';
import 'package:base/repository/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as _;

class LocationState with ChangeNotifier {
  final LocalStorage localStorage;
  LocationState(this.localStorage);
  final LocationController _eventController = LocationController();

  bool get editStatus => _editStatus;

  List<Location> get locationList => _locationList;

  Location get selectedLocation => _selectedLocation;

  List<Location> get searchList => _searchList;

  List<Location> _searchList = [];

  bool _editStatus = false;

  List<Location> _locationList = [];

  late Location _selectedLocation;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

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

  Future<dynamic> fetchLocationData(String token) async {
    try {
      _locationList = await _eventController.fetchLocations(token);
      _searchList.addAll(_locationList);

      notifyListeners();
    } on Exception catch (_) {
      return _.toString();
    }
  }

  Future<dynamic> fetchSelectedLocationData(Location location) async {
    try {
      _selectedLocation = location;
      _isLoading = false;
      //    notifyListeners();
    } on Exception catch (_) {
      return _.toString();
    }
  }

  changeEditState() {
    _editStatus = !_editStatus;

    notifyListeners();
  }

  void filterSearchResults(String query) {
    List<Location> dummySearchList = [];
    dummySearchList.addAll(_locationList);
    if (query.isNotEmpty) {
      List<Location> dummyListData = [];
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
    _selectedLocation.latitude = location.latitude.toString();
    _selectedLocation.longitude = location.longitude.toString();

    notifyListeners();
  }

  resetSearch() {
    _searchList.clear();
    _searchList.addAll(_locationList);
    notifyListeners();
  }
}
