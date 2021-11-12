abstract class IContactRepository {
  /// contact
  Future<dynamic> fetchListOfUsers(String token);

  Future<dynamic> fetchListOfFavorites(String token);

  Future<dynamic> fetchListOfBoardmembers(String token);

  Future<dynamic> addUserToFavorite(String token, int id);

  Future<dynamic> removeUserFromFavorite(String token, int id);

  Future<dynamic> fetchSelectedUser(String token, int id);

  Future<dynamic> saveContactUserData(
      Map<String, dynamic> profileForm, String token, int id);
}
