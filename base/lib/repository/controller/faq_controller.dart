import 'package:base/repository/repository.dart';
import 'package:base/repository/repository_interface.dart';

class FaqController {
  final IHeilooRepository _heilooRepository = HeilooRepository();

  Future<dynamic> fetchFaqData(String token) {
    return _heilooRepository.getFaqData(token);
  }
}
