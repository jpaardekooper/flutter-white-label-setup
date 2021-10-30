import 'package:base/repository/repository.dart';
import 'package:base/repository/repository_interface.dart';

class EventController {
  final IHeilooRepository _heilooRepository = HeilooRepository();

  // Future<dynamic> fetchEventData(String token, bool active) {
  //   return _heilooRepository.getEventData(token, active);
  // }

  Future<dynamic> fetchEvents(String token, bool active) {
    return _heilooRepository.fetchEvents(token, active);
  }

  Future<dynamic> fetchSelectedEvent(String token, int id) {
    return _heilooRepository.fetchSelectedEvent(token, id);
  }

  Future<dynamic> setUserAttendence(
      String token, int eventId, int userId, Map<String, dynamic> eventForm) {
    return _heilooRepository.setUserEventAttendance(
        token, eventId, userId, eventForm);
  }

  Future<dynamic> saveSelectedEventInfo(
      String token, int eventId, Map<String, dynamic> eventForm) {
    return _heilooRepository.saveSelectedEventInformation(
        token, eventId, eventForm);
  }
}
