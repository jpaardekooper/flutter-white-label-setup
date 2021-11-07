import 'dart:convert';
import 'dart:io';
import 'package:base/models/custom_exception.dart';
import 'package:base/models/error.dart';
import 'package:base/repository/interface/event_repository_interface.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EventRepository implements IEventRepository {
  final String baseUrl = dotenv.env['BASE_API'].toString();
  final String header_x_portal = dotenv.env['HEADER_X_PORTAL_NAME'].toString();
  final String header_x_request =
      dotenv.env['HEADER_X_REQUESTED_WITH'].toString();

  dynamic getResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 204:
        return response;

      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        ErrorMessage _error = ErrorMessage.fromJson(json.decode(response.body));
        throw UnauthorisedException(_error.status, _error.title);
      case 500:
      default:
        throw FetchDataException(
            // ignore: lines_longer_than_80_chars
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  @override
  Future<dynamic> fetchEvents(String token, bool active) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/events?active=$active"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
          'Authorization': 'Bearer $token'
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }
    return response;
  }

  @override
  Future<dynamic> fetchSelectedEvent(String token, int id) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/events/$id"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
          'Authorization': 'Bearer $token'
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }
    return response;
  }

  @override
  Future<dynamic> saveSelectedEventInformation(
      String token, int eventId, Map<String, dynamic> eventForm) async {
    Response response;

    print(jsonEncode(eventForm));

    try {
      response = await put(
        Uri.parse(baseUrl + "/events/$eventId"),
        body: jsonEncode(eventForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
          'Authorization': 'Bearer $token'
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }
    return response;
  }

  @override
  Future<dynamic> setUserEventAttendance(String token, int eventId, int userId,
      Map<String, dynamic> eventForm) async {
    Response response;

    try {
      response = await put(
        Uri.parse(baseUrl + "/events/$eventId/users/$userId"),
        body: jsonEncode(eventForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
          'Authorization': 'Bearer $token'
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }
    return response;
  }
}
