import 'package:base/repository/repository.dart';
import 'package:base/repository/repository_interface.dart';

class SocialController {
  final IHeilooRepository _heilooRepository = HeilooRepository();

  Future<dynamic> fetchTweets(int count) {
    return _heilooRepository.getTimelineTweets(count);
  }
}
