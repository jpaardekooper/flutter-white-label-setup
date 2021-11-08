import 'package:base/repository/faq_repository.dart';
import 'package:base/repository/interface/faq_repository_interface.dart';

class FaqController {
  final IFaqRepository _faqRepository = FaqRepository();

  Future<dynamic> fetchFaqData(String token) {
    return _faqRepository.getFaqData(token);
  }
}
