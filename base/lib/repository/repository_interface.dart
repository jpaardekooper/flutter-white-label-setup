import 'package:http/http.dart';

abstract class IHeilooRepository {
  /// app user
  Future<dynamic> login(Map<String, dynamic> loginForm);

  Future<dynamic> checkAndSetSession(String token);

  Future<dynamic> refreshSession(Map<String, dynamic> refreshForm);

  Future<dynamic> resetPassword();

  /// contact
  Future<dynamic> fetchListOfUsers(String token);

  Future<dynamic> fetchListOfFavorites(String token);

  Future<dynamic> fetchListOfBoardmembers(String token);

  Future<dynamic> addUserToFavorite(String token, int id);

  Future<dynamic> removeUserFromFavorite(String token, int id);

  Future<dynamic> fetchSelectedUser(String token, int id);

  Future<dynamic> saveContactUserData(
      Map<String, dynamic> profileForm, String token, int id);

  /// events

  Future<dynamic> fetchEvents(String token, bool active);

  Future<dynamic> fetchSelectedEvent(String token, int id);

  Future<dynamic> setUserEventAttendance(
      String token, int eventId, int userId, Map<String, dynamic> eventForm);

  Future<dynamic> saveSelectedEventInformation(
      String token, int eventId, Map<String, dynamic> eventForm);

  /// faq

  Future<dynamic> getFaqData(String token);

  Future<dynamic> getTimelineTweets(int count);

  // locations

  Future<dynamic> getLocations(String token);

  Future<dynamic> getLocationDetails(String token, int id);

  dynamic getResponse(Response response);
}
