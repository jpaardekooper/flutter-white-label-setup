import 'dart:convert';

import 'package:base/helper/shared_preference.dart';
import 'package:base/models/event_users.dart';
import 'package:base/models/events.dart';
import 'package:base/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:base/repository/controller/event_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class EventState with ChangeNotifier {
  final LocalStorage localStorage;
  final AuthState authState;
  EventState(this.localStorage, this.authState);

  late Events _selectedEvent;
  Events get selectedEvent => _selectedEvent;

  final EventController _eventController = EventController();

  List<EventUsers> going = [];
  List<EventUsers> maybeGoing = [];
  List<EventUsers> notGoing = [];

  EventUsers? _selectedUserForEvent;
  EventUsers? get selectedUserForEvent => _selectedUserForEvent;

  List<Events> _eventsList = [];
  List<Events> get eventsList => _eventsList;

  fetchEvents() async {
    try {
      if (await authState.refreshSession()) {
        Response result = await _eventController.fetchEvents(
            authState.token.accessToken!.bearerToken!, false);
        // print(result);
        // print('de response is ${result.statusCode}');
        if (result.statusCode == 200) {
          List<dynamic> parsed = json.decode(result.body) as List;
          _eventsList = parsed.map((val) => Events.fromJson(val)).toList();

          notifyListeners();
        }
      }
    } on Exception catch (_) {
      return [];
    }
  }

  setSelectedEvent(Events event) {
    _selectedEvent = event;
    notifyListeners();
  }

  Future<Events?> fetchEventsById() async {
    going.clear();
    notGoing.clear();
    maybeGoing.clear();

    _selectedUserForEvent = EventUsers(
        id: authState.appUser.id,
        userName: authState.fullName(authState.appUser.firstName,
            authState.appUser.insertion, authState.appUser.lastName),
        userImage: authState.appUser.profilePicture,
        isGoing: null,
        takesGuest: false);

    try {
      if (await authState.refreshSession()) {
        Response result = await _eventController.fetchSelectedEvent(
            authState.token.accessToken!.bearerToken!, selectedEvent.id!);
        // print(result);
        // print('de response is ${result.statusCode}');
        if (result.statusCode == 200) {
          _selectedEvent = Events.fromJson(json.decode(result.body));

          if (_selectedEvent.eventUsers != null &&
              _selectedEvent.eventUsers!.isNotEmpty) {
            for (int i = 0; i < _selectedEvent.eventUsers!.length; i++) {
              EventUsers eventUser = _selectedEvent.eventUsers![i]!;

              if (eventUser.id == authState.appUser.id) {
                _selectedUserForEvent = null;
                _selectedUserForEvent = eventUser;
                _selectedUserForEvent?.takesGuest =
                    _selectedUserForEvent?.takesGuest ?? false;
              }

              switch (eventUser.isGoing) {
                case 0:
                  going.add(eventUser);
                  break;
                case 1:
                  maybeGoing.add(eventUser);
                  break;
                case 2:
                  notGoing.add(eventUser);
                  break;
                default:
              }
            }
          }
        }
        notifyListeners();
      }
      return selectedEvent;
    } on Exception catch (_) {
      return null;
    }
  }

  updateLocalList(int value) {
    switch (value) {
      case 0:
        selectedUserForEvent!.isGoing = 0;

        going.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        going.add(_selectedUserForEvent!);

        maybeGoing.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        notGoing.removeWhere((data) => data.id == selectedUserForEvent!.id);

        notifyListeners();

        break;
      case 1:
        selectedUserForEvent!.isGoing = 1;
        maybeGoing.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        maybeGoing.add(_selectedUserForEvent!);

        going.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        notGoing.removeWhere((data) => data.id == selectedUserForEvent!.id);

        notifyListeners();
        break;
      case 2:
        selectedUserForEvent!.isGoing = 2;

        notGoing.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        notGoing.add(_selectedUserForEvent!);

        going.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        maybeGoing.removeWhere((data) => data.id == selectedUserForEvent!.id);

        notifyListeners();
        break;

      default:
        selectedUserForEvent!.isGoing = -1;
        going.removeWhere((data) => data.id == _selectedUserForEvent!.id);
        notGoing.removeWhere((data) => data.id == _selectedUserForEvent!.id);

        maybeGoing.removeWhere((data) => data.id == selectedUserForEvent!.id);

        notifyListeners();
        break;
    }
  }

  attendEvent(int value) async {
    try {
      if (await authState.refreshSession()) {
        updateLocalList(value);

        selectedUserForEvent?.takesGuest ??= false;

        Map<String, dynamic> eventForm = {
          "eventId": selectedEvent.id!,
          "userId": authState.appUser.id!,
          "isGoing": selectedUserForEvent!.isGoing,
          "takesGuest": selectedUserForEvent!.takesGuest
        };

        Response result = await _eventController.setUserAttendence(
            authState.token.accessToken!.bearerToken!,
            selectedEvent.id!,
            authState.appUser.id!,
            eventForm);

        // print(result);
        // print('de response is ${result.statusCode}');
        if (result.statusCode == 200 || result.statusCode == 204) {}

        notifyListeners();
      }
    } on Exception catch (_) {
      return null;
    }
  }

  Future<bool> updateSelectedEventInformation() async {
    try {
      if (await authState.refreshSession()) {
        print(selectedEvent.eventUsers!.length);

        Map<String, dynamic> eventForm = {
          "title": selectedEvent.title,
          "description": selectedEvent.description,
          "startDate": selectedEvent.startDate?.toIso8601String(),
          "endDate": selectedEvent.endDate?.toIso8601String(),
          "publishDate": selectedEvent.publishDate?.toIso8601String(),
          "active": selectedEvent.active,
          "url": selectedEvent.url,
          "venueName": selectedEvent.venueName,
          "longitude": selectedEvent.longitude,
          "latitude": selectedEvent.latitude,
          "visualImage": selectedEvent.visualImage,
          "mayTakeGuest": selectedEvent.mayTakeGuest,
          "organizationId": selectedEvent.organizationId,
          "id": selectedEvent.id,
        };

        Response result = await _eventController.saveSelectedEventInfo(
            authState.token.accessToken!.bearerToken!,
            selectedEvent.id!,
            eventForm);
        if (result.statusCode == 200 || result.statusCode == 204) {
          return true;
        } else {
          print(result.body);
          return false;
        }
      } else {
        return false;
      }
    } on Exception catch (_) {
      print(_);
      return false;
    }
  }

  updateTitle(String value) {
    _selectedEvent.title = value;
    notifyListeners();
  }

  updateDescription(String value) {
    _selectedEvent.description = value;
    notifyListeners();
  }

  updateVenueName(String value) {
    _selectedEvent.venueName = value;
    notifyListeners();
  }

  updateStartDate(DateTime value) {
    _selectedEvent.startDate = value;
    notifyListeners();
  }

  updateEndDate(DateTime value) {
    _selectedEvent.endDate = value;
    notifyListeners();
  }

  updateUrl(String value) {
    _selectedEvent.url = value;
    notifyListeners();
  }

  updateLongitude(LatLng latlng) {
    _selectedEvent.latitude = latlng.latitude;
    _selectedEvent.longitude = latlng.longitude;
  }

  updateMayTakeGuest(bool value) {
    _selectedEvent.mayTakeGuest = value;
    notifyListeners();
  }
}
