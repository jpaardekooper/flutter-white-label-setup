import 'dart:convert';
import 'package:base/models/custom_exception.dart';
import 'package:base/models/error.dart';
import 'package:base/repository/interface/social_repository_interface.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:dart_twitter_api/twitter_api.dart' as tw;

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

class SocialRepository implements ISocialRepository {
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

  Future<dynamic> getTimelineTweets(int count) async {
    try {
      var tweett;

      var twitterApi = tw.TwitterApi(
        client: tw.TwitterClient(
          consumerKey: dotenv.env['CONSUMER_KEY'].toString(),
          consumerSecret: dotenv.env['CONSUMER_SECRET'].toString(),
          token: dotenv.env['TOKEN'].toString(),
          secret: dotenv.env['SECRET'].toString(),
        ),
      );

      var params = <String, String>{}
        ..addParameter('user_id', dotenv.env['ORGANISATION_TWITTER'].toString())
        ..addParameter(
            'screen_name', dotenv.env['ORGANISATION_TWITTER'].toString())
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
}
