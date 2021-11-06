import 'package:base/repository/login_repository.dart';
import 'package:base/repository/interface/login_repository_interfaces.dart';

class LoginController {
  final ILoginRepository _loginRepository = LoginRepository();

  Future<dynamic> login(Map<String, dynamic> loginForm) {
    return _loginRepository.login(loginForm);
  }

  Future<dynamic> refreshSession(Map<String, dynamic> refreshForm) {
    return _loginRepository.refreshSession(refreshForm);
  }

  dynamic checkAndSetSession(String token) {
    return _loginRepository.checkAndSetSession(token);
  }

  Future<dynamic> resetPassword(Map<String, dynamic> email) {
    return _loginRepository.login(email);
  }
}
