import 'package:base/repository/repository.dart';
import 'package:base/repository/repository_interface.dart';

class AuthController {
  final IHeilooRepository _heilooRepository = HeilooRepository();

  Future<dynamic> login(Map<String, dynamic> loginForm) {
    return _heilooRepository.login(loginForm);
  }

  Future<dynamic> refreshSession(Map<String, dynamic> refreshForm) {
    return _heilooRepository.refreshSession(refreshForm);
  }

  dynamic checkAndSetSession(String token) {
    return _heilooRepository.checkAndSetSession(token);
  }

  Future<dynamic> resetPassword(Map<String, dynamic> email) {
    return _heilooRepository.login(email);
  }
}
