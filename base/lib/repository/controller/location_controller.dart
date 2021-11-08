import 'package:base/repository/interface/spotted_location_repository_interface.dart';
import 'package:base/repository/spotted_location_repository.dart';

class LocationController {
  final ISpottedLocationRepository _locationRepository =
      SpottedLocationRepository();

  Future<dynamic> fetchLocations(String token) {
    return _locationRepository.getLocations(token);
  }

  Future<dynamic> fetchLocationDetails(String token, int id) {
    return _locationRepository.getLocationDetails(token, id);
  }
}
