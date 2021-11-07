import 'dart:convert';
import 'dart:io';
import 'package:base/models/custom_exception.dart';

import 'package:base/models/error.dart';
import 'package:base/repository/interface/contact_repository_interface.dart';
import 'package:http/http.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContactRepository implements IContactRepository {
  final String baseUrl = dotenv.env['BASE_API'].toString();
  final String header_x_portal = dotenv.env['HEADER_X_PORTAL_NAME'].toString();
  final String header_x_request =
      dotenv.env['HEADER_X_REQUESTED_WITH'].toString();

  // final FlavorConfig config = FlavorConfig();
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
  Future<dynamic> fetchListOfUsers(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/users"),
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
  Future<dynamic> fetchListOfFavorites(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/users/favorites"),
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
  Future<dynamic> fetchListOfBoardmembers(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/users/boardmembers"),
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
  Future<dynamic> addUserToFavorite(String token, int id) async {
    Response response;
    try {
      response = await post(
        Uri.parse(baseUrl + "/users/favorite/$id"),
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
  Future<dynamic> removeUserFromFavorite(String token, int id) async {
    Response response;
    try {
      response = await delete(
        Uri.parse(baseUrl + "/users/favorite/$id"),
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
  Future<dynamic> fetchSelectedUser(String token, id) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/users/$id"),
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
  Future<dynamic> saveContactUserData(
      Map<String, dynamic> profileForm, String token, int id) async {
    Response response;
    try {
      response = await put(
        Uri.parse(baseUrl + "/users/$id"),
        body: jsonEncode(profileForm),
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
