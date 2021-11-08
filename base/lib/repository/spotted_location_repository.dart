import 'dart:convert';
import 'dart:io';
import 'package:base/models/custom_exception.dart';
import 'package:base/models/error.dart';
import 'package:base/models/spotted_location.dart';
import 'package:base/repository/interface/spotted_location_repository_interface.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpottedLocationRepository implements ISpottedLocationRepository {
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
  Future<dynamic> getLocations(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/locations"),
        headers: {
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
  Future<dynamic> getLocationDetails(String token, int id) async {
    try {
      //   var result;

      Response response = await get(
        Uri.parse(baseUrl + "/location/$id"),
        headers: {
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // List<dynamic> parsed = json.decode(response.body);
        // result = parsed.map((val) => EventModel.fromJson(val)).toList();
      }

      return SpottedLocation('Test', null, null, null, null, null, null, null,
          null, null, null, null, null, null);
    } on Exception catch (_) {
      throw _;
    }
  }
}
