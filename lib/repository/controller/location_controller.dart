import 'package:base/repository/repository.dart';
import 'package:base/repository/repository_interface.dart';

class LocationController {
  final IHeilooRepository _heilooRepository = HeilooRepository();

  Future<dynamic> fetchLocations(String token) {
    return _heilooRepository.getLocations(token);
  }

  Future<dynamic> fetchLocationDetails(String token, int id) {
    return _heilooRepository.getLocationDetails(token, id);
  }
}
