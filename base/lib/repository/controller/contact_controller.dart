import 'package:base/repository/repository.dart';
import 'package:base/repository/repository_interface.dart';

class ContactController {
  final IHeilooRepository _heilooRepository = HeilooRepository();

  Future<dynamic> fetchContactData(String token) {
    return _heilooRepository.fetchListOfUsers(token);
  }

  Future<dynamic> fetchFavoriteList(String token) {
    return _heilooRepository.fetchListOfFavorites(token);
  }

  Future<dynamic> fetchBoardmemberList(String token) {
    return _heilooRepository.fetchListOfBoardmembers(token);
  }

  Future<dynamic> addUserToFavorite(String token, int id) {
    return _heilooRepository.addUserToFavorite(token, id);
  }

  Future<dynamic> removeUserFromFavorite(String token, int id) {
    return _heilooRepository.removeUserFromFavorite(token, id);
  }

  Future<dynamic> getSelectedUser(String token, int id) {
    return _heilooRepository.fetchSelectedUser(token, id);
  }

  // Future<ContactModel> fetchContactDetails(String token, int id) {
  //   return _heilooRepository.getContactDetails(token, id);
  // }

  Future<dynamic> saveContactUserData(
      Map<String, dynamic> profileForm, String token, int id) {
    return _heilooRepository.saveContactUserData(profileForm, token, id);
  }
}
