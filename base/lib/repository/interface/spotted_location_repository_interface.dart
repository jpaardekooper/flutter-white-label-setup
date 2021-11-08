abstract class ISpottedLocationRepository {
  // locations

  Future<dynamic> getLocations(String token);

  Future<dynamic> getLocationDetails(String token, int id);
}
