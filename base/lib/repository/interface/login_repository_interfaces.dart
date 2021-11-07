abstract class ILoginRepository {
  Future<dynamic> login(Map<String, dynamic> loginForm);

  Future<dynamic> checkAndSetSession(String token);

  Future<dynamic> refreshSession(Map<String, dynamic> refreshForm);

  Future<dynamic> resetPassword();
}
