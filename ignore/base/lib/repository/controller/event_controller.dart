import 'package:base/repository/event_repository.dart';
import 'package:base/repository/interface/event_repository_interface.dart';

class EventController {
  final IEventRepository _eventRepository = EventRepository();

  // Future<dynamic> fetchEventData(String token, bool active) {
  //   return _eventRepository.getEventData(token, active);
  // }

  Future<dynamic> fetchEvents(String token, bool active) {
    return _eventRepository.fetchEvents(token, active);
  }

  Future<dynamic> fetchSelectedEvent(String token, int id) {
    return _eventRepository.fetchSelectedEvent(token, id);
  }

  Future<dynamic> setUserAttendence(
      String token, int eventId, int userId, Map<String, dynamic> eventForm) {
    return _eventRepository.setUserEventAttendance(
        token, eventId, userId, eventForm);
  }

  Future<dynamic> saveSelectedEventInfo(
      String token, int eventId, Map<String, dynamic> eventForm) {
    return _eventRepository.saveSelectedEventInformation(
        token, eventId, eventForm);
  }
}
