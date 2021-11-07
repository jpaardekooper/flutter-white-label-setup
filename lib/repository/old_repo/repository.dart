// import 'dart:convert';
// import 'dart:io';
// import 'package:base/models/custom_exception.dart';
// import 'package:base/models/spotted_location.dart';
// import 'package:base/models/error.dart';
// import 'package:base/repository/old_repo/repository_interface.dart';
// import 'package:http/http.dart';
// import 'package:tweet_ui/models/api/tweet.dart';
// import 'package:dart_twitter_api/twitter_api.dart' as tw;
// import 'dart:math';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// extension ParameterExtension on Map<String, String> {
//   /// Adds an entry to the map.
//   ///
//   /// If [value] is `null`, it is not added to the map.
//   /// If [value] is a [List], the list is joined with a `,`.
//   /// Else, the [value.toString()] is used.
//   void addParameter(String param, dynamic value) {
//     if (value is List) {
//       this[param] = value.join(',');
//     } else if (value != null) {
//       this[param] = '$value';
//     }
//   }
// }

// class HeilooRepository implements IHeilooRepository {
//   final String baseUrl = dotenv.env['BASE_API'].toString();
//   final String header_x_portal = dotenv.env['HEADER_X_PORTAL_NAME'].toString();
//   final String header_x_request =
//       dotenv.env['HEADER_X_REQUESTED_WITH'].toString();

//   // final FlavorConfig config = FlavorConfig();
//   dynamic getResponse(Response response) {
//     switch (response.statusCode) {
//       case 200:
//       case 204:
//         return response;

//       case 400:
//         throw BadRequestException(response.body.toString());
//       case 401:
//       case 403:
//         ErrorMessage _error = ErrorMessage.fromJson(json.decode(response.body));
//         throw UnauthorisedException(_error.status, _error.title);
//       case 500:
//       default:
//         throw FetchDataException(
//             // ignore: lines_longer_than_80_chars
//             'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
//     }
//   }

//   @override
//   Future<dynamic> fetchListOfUsers(String token) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/users"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> fetchListOfFavorites(String token) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/users/favorites"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> fetchListOfBoardmembers(String token) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/users/boardmembers"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> addUserToFavorite(String token, int id) async {
//     Response response;
//     try {
//       response = await post(
//         Uri.parse(baseUrl + "/users/favorite/$id"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> removeUserFromFavorite(String token, int id) async {
//     Response response;
//     try {
//       response = await delete(
//         Uri.parse(baseUrl + "/users/favorite/$id"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> fetchSelectedUser(String token, id) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/users/$id"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );
//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> saveContactUserData(
//       Map<String, dynamic> profileForm, String token, int id) async {
//     Response response;
//     try {
//       response = await put(
//         Uri.parse(baseUrl + "/users/$id"),
//         body: jsonEncode(profileForm),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> fetchEvents(String token, bool active) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/events?active=$active"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> fetchSelectedEvent(String token, int id) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/events/$id"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> saveSelectedEventInformation(
//       String token, int eventId, Map<String, dynamic> eventForm) async {
//     Response response;

//     print(jsonEncode(eventForm));

//     try {
//       response = await put(
//         Uri.parse(baseUrl + "/events/$eventId"),
//         body: jsonEncode(eventForm),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> setUserEventAttendance(String token, int eventId, int userId,
//       Map<String, dynamic> eventForm) async {
//     Response response;

//     try {
//       response = await put(
//         Uri.parse(baseUrl + "/events/$eventId/users/$userId"),
//         body: jsonEncode(eventForm),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> getLocations(String token) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/locations"),
//         headers: {
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   @override
//   Future<dynamic> getLocationDetails(String token, int id) async {
//     try {
//       //   var result;

//       Response response = await get(
//         Uri.parse(baseUrl + "/location/$id"),
//         headers: {
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       if (response.statusCode == 200) {
//         // List<dynamic> parsed = json.decode(response.body);
//         // result = parsed.map((val) => EventModel.fromJson(val)).toList();
//       }

//       return SpottedLocation('Test', null, null, null, null, null, null, null,
//           null, null, null, null, null, null);
//     } on Exception catch (_) {
//       throw _;
//     }
//   }

//   @override
//   Future<dynamic> getFaqData(String token) async {
//     Response response;
//     try {
//       response = await get(
//         Uri.parse(baseUrl + "/faq-items"),
//         headers: {
//           'Content-Type': 'application/json',
//           'X-Organization-Code': header_x_portal,
//           'x-required-with': header_x_request,
//           'Authorization': 'Bearer $token'
//         },
//       );

//       response = getResponse(response);
//     } on SocketException catch (_) {
//       throw FetchDataException('no internet connection');
//     }
//     return response;
//   }

//   Future<dynamic> getTimelineTweets(int count) async {
//     try {
//       var tweett;

//       var twitterApi = tw.TwitterApi(
//         client: tw.TwitterClient(
//           consumerKey: dotenv.env['CONSUMER_KEY'].toString(),
//           consumerSecret: dotenv.env['CONSUMER_SECRET'].toString(),
//           token: dotenv.env['TOKEN'].toString(),
//           secret: dotenv.env['SECRET'].toString(),
//         ),
//       );

//       var params = <String, String>{}
//         ..addParameter('user_id', dotenv.env['ORGANISATION_TWITTER'].toString())
//         ..addParameter(
//             'screen_name', dotenv.env['ORGANISATION_TWITTER'].toString())
//         ..addParameter('count', count);

//       Response test = await twitterApi.client.get(Uri.https(
//         'api.twitter.com',
//         '1.1/statuses/user_timeline.json',
//         params,
//       ));

//       if (test.statusCode == 200) {
//         List<dynamic> parsed = json.decode(test.body);
//         tweett = parsed.map((val) => Tweet.fromJson(val)).toList();
//       }

//       return tweett;
//     } catch (error) {
//       print('error while requesting home timeline: $error');
//     }
//   }
// }
