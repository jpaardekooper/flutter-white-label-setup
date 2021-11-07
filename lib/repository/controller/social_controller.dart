import 'package:base/repository/interface/social_repository_interface.dart';
import 'package:base/repository/social_repository.dart';

class SocialController {
  final ISocialRepository _socialRepository = SocialRepository();

  Future<dynamic> fetchTweets(int count) {
    return _socialRepository.getTimelineTweets(count);
  }
}
