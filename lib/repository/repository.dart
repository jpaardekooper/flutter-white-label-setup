import 'dart:convert';
import 'dart:io';
import 'package:base/models/custom_exception.dart';
import 'package:base/models/location_model.dart';
import 'package:base/models/error.dart';
import 'package:http/http.dart';
import 'package:base/repository/repository_interface.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:dart_twitter_api/twitter_api.dart' as tw;
import 'dart:math';
import 'package:flutter_config/flutter_config.dart';

extension ParameterExtension on Map<String, String> {
  /// Adds an entry to the map.
  ///
  /// If [value] is `null`, it is not added to the map.
  /// If [value] is a [List], the list is joined with a `,`.
  /// Else, the [value.toString()] is used.
  void addParameter(String param, dynamic value) {
    if (value is List) {
      this[param] = value.join(',');
    } else if (value != null) {
      this[param] = '$value';
    }
  }
}

class HeilooRepository implements IHeilooRepository {
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
  Future<dynamic> login(Map<String, dynamic> loginForm) async {
    Response response;
    print(FlutterConfig.get('API_BASE_URL_TEST'));
    try {
      response = await post(
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/accounts/login"),
        body: jsonEncode(loginForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') +
            "/accounts/refresh-session"),
        body: jsonEncode(refreshForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/accounts/me"),
        // body: jsonEncode(loginForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
  Future<dynamic> fetchListOfUsers(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/users"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/users/favorites"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(
            FlutterConfig.get('API_BASE_URL_TEST') + "/users/boardmembers"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(
            FlutterConfig.get('API_BASE_URL_TEST') + "/users/favorite/$id"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(
            FlutterConfig.get('API_BASE_URL_TEST') + "/users/favorite/$id"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/users/$id"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/users/$id"),
        body: jsonEncode(profileForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
  Future<dynamic> fetchEvents(String token, bool active) async {
    Response response;
    try {
      response = await get(
        Uri.parse(
            FlutterConfig.get('API_BASE_URL_TEST') + "/events?active=$active"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/events/$id"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/events/$eventId"),
        body: jsonEncode(eventForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') +
            "/events/$eventId/users/$userId"),
        body: jsonEncode(eventForm),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
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
  Future<dynamic> getLocations(String token) async {
    try {
      var result;

      Response response = await get(
        Uri.parse(FlutterConfig.get('API_BASE_URL') + "/location"),
        headers: {
          //  'x-organization-code':
          'x-portal-name': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // List<dynamic> parsed = json.decode(response.body);
        // result = parsed.map((val) => EventModel.fromJson(val)).toList();
      }
      Random random = Random();
      List<Location> test = [];
      for (int i = 0; i < 10; i++) {
        test.add(Location(
          'latitude $i ',
          'longitude $i',
          'title ${random.nextInt(100)}',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam facilisis cursus ipsum eget elementum. Duis felis augue, eleifend vitae velit quis, bibendum convallis quam. Nunc ac blandit felis. Vivamus vitae sodales enim. Aliquam rutrum efficitur lorem, non \n \n Fusce maximus pulvinar massa quis consectetur. Cras sodales facilisis ipsum, sit amet pretium dolor molestie facilisis. Nam commodo pharetra elementum. Aliquam vitae enim ullamcorper nisl efficitur commodo. Curabitur at facilisis tortor, ac luctus ipsum. Mauris consectetur tortor sit amet ex eleifend, eget sodales arcu sodales. Cras vehicula nisi vel odio mattis, eu fringilla metus porta.',
          'zipcode $i',
          'address $i',
          'city $i',
          'url $i',
        ));
      }
      return test;
    } on Exception catch (_) {
      throw _;
    }
  }

  @override
  Future<dynamic> getLocationDetails(String token, int id) async {
    try {
      //   var result;

      Response response = await get(
        Uri.parse(FlutterConfig.get('API_BASE_URL') + "/location/$id"),
        headers: {
          'x-portal-name': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // List<dynamic> parsed = json.decode(response.body);
        // result = parsed.map((val) => EventModel.fromJson(val)).toList();
      }

      return Location(
        'latitude',
        'longitude',
        'title',
        'description',
        'zipcode',
        'address',
        'city',
        'url',
      );
    } on Exception catch (_) {
      throw _;
    }
  }

  @override
  Future<dynamic> getFaqData(String token) async {
    Response response;
    try {
      response = await get(
        Uri.parse(FlutterConfig.get('API_BASE_URL_TEST') + "/faq-items"),
        headers: {
          'Content-Type': 'application/json',
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME'),
          'x-required-with': FlutterConfig.get('HEADER_X_REQUESTED_WITH'),
          'Authorization': 'Bearer $token'
        },
      );

      response = getResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException('no internet connection');
    }
    return response;
  }

  Future<dynamic> getTimelineTweets(int count) async {
    try {
      var tweett;

      var twitterApi = tw.TwitterApi(
        client: tw.TwitterClient(
          consumerKey: FlutterConfig.get('CONSUMER_KEY'),
          consumerSecret: FlutterConfig.get('CONSUMER_SECRET'),
          token: FlutterConfig.get('TOKEN'),
          secret: FlutterConfig.get('SECRET'),
        ),
      );

      var params = <String, String>{}
        ..addParameter('user_id', FlutterConfig.get('ORGANISATION_TWITTER'))
        ..addParameter('screen_name', FlutterConfig.get('ORGANISATION_TWITTER'))
        ..addParameter('count', count);

      Response test = await twitterApi.client.get(Uri.https(
        'api.twitter.com',
        '1.1/statuses/user_timeline.json',
        params,
      ));

      if (test.statusCode == 200) {
        List<dynamic> parsed = json.decode(test.body);
        tweett = parsed.map((val) => Tweet.fromJson(val)).toList();
      }

      return tweett;
    } catch (error) {
      print('error while requesting home timeline: $error');
    }
  }

  Future<dynamic> resetPassword() async {
    try {
      bool result = false;

      Response response = await get(
        Uri.parse(
            "https://contactapp-api-test.azurewebsites.net/accounts/request-password-reset"),
        headers: {
          'X-Organization-Code': FlutterConfig.get('HEADER_X_PORTAL_NAME')
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
