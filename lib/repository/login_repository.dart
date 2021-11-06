import 'dart:convert';
import 'dart:io';
import 'package:base/models/custom_exception.dart';
import 'package:base/models/error.dart';
import 'package:base/repository/interface/login_repository_interfaces.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginRepository implements ILoginRepository {
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
  Future<dynamic> login(Map<String, dynamic> loginForm) async {
    Response response;
    try {
      response = await post(
        Uri.parse(baseUrl + "/accounts/login"),
        body: jsonEncode(loginForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }

    return response;
  }

  @override
  Future<dynamic> refreshSession(Map<String, dynamic> refreshForm) async {
    Response response;

    try {
      response = await post(
        Uri.parse(baseUrl + "/accounts/refresh-session"),
        body: jsonEncode(refreshForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': header_x_portal,
          'x-required-with': header_x_request,
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }

    return response;
  }

  @override
  Future<dynamic> checkAndSetSession(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(baseUrl + "/accounts/me"),
        // body: jsonEncode(loginForm),
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

  Future<dynamic> resetPassword() async {
    try {
      bool result = false;

      Response response = await get(
        Uri.parse(
            "https://contactapp-api-test.azurewebsites.net/accounts/request-password-reset"),
        headers: {
          'X-Organization-Code': header_x_portal,
        },
      );

      if (response.statusCode == 200) {
        result = true;
      }

      return result;
    } on Exception catch (_) {
      throw _;
    }
  }
}
