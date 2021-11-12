abstract class IEventRepository {
  /// events

  Future<dynamic> fetchEvents(String token, bool active);

  Future<dynamic> fetchSelectedEvent(String token, int id);

  Future<dynamic> setUserEventAttendance(
      String token, int eventId, int userId, Map<String, dynamic> eventForm);

  Future<dynamic> saveSelectedEventInformation(
      String token, int eventId, Map<String, dynamic> eventForm);
}
