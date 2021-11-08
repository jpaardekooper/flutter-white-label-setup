import 'package:base/repository/contact_repository.dart';
import 'package:base/repository/interface/contact_repository_interface.dart';

class ContactController {
  final IContactRepository _contactRepository = ContactRepository();

  Future<dynamic> fetchContactData(String token) {
    return _contactRepository.fetchListOfUsers(token);
  }

  Future<dynamic> fetchFavoriteList(String token) {
    return _contactRepository.fetchListOfFavorites(token);
  }

  Future<dynamic> fetchBoardmemberList(String token) {
    return _contactRepository.fetchListOfBoardmembers(token);
  }

  Future<dynamic> addUserToFavorite(String token, int id) {
    return _contactRepository.addUserToFavorite(token, id);
  }

  Future<dynamic> removeUserFromFavorite(String token, int id) {
    return _contactRepository.removeUserFromFavorite(token, id);
  }

  Future<dynamic> getSelectedUser(String token, int id) {
    return _contactRepository.fetchSelectedUser(token, id);
  }

  // Future<ContactModel> fetchContactDetails(String token, int id) {
  //   return _heilooRepository.getContactDetails(token, id);
  // }

  Future<dynamic> saveContactUserData(
      Map<String, dynamic> profileForm, String token, int id) {
    return _contactRepository.saveContactUserData(profileForm, token, id);
  }
}
