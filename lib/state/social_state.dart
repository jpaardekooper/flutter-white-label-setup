import 'package:base/helper/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:base/repository/controller/social_controller.dart';
//import 'package:tweet_ui/models/api/tweet.dart';

class SocialState with ChangeNotifier {
  final LocalStorage localStorage;
  SocialState(this.localStorage);

  final SocialController _socialController = SocialController();

  List<dynamic> get tweetList => _tweetList;

  //List<Tweet> _tweetList = [];
  List<dynamic> _tweetList = [];

  Future<dynamic> fetchTweets(int count) async {
    try {
      _tweetList = await _socialController.fetchTweets(count);

      notifyListeners();
    } on Exception catch (_) {
      return _.toString();
    }
  }
}
