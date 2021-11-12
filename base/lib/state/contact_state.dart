import 'dart:convert';
import 'package:base/helper/shared_preference.dart';
import 'package:base/models/contact_user.dart';
import 'package:flutter/material.dart';
import 'package:base/repository/controller/contact_controller.dart';
import 'package:http/http.dart';
import 'auth_state.dart';

enum ListType { contactList, favoriteList, boardmemberList }

class ContactState with ChangeNotifier {
  ContactState(this.SharedPreferences, this.test);

  final ContactController _contactController = ContactController();
  final AuthState test;

  final LocalStorage SharedPreferences;

  //list of fetched contacts
  List<ContactUser> _contactList = [];
  // fetched favorites
  List<ContactUser> _favoriteList = [];
  //fetched boardmembers
  List<ContactUser> _boardList = [];

  List<ContactUser> _searchList = [];
  List<ContactUser> get listOfContacts => _searchList;

  List<ContactUser> _searchFavoriteList = [];
  List<ContactUser> get listOfFavotire => _searchFavoriteList;

  List<ContactUser> _searchListBoards = [];
  List<ContactUser> get listOfBoardMembers => _searchListBoards;

  bool _searchToggle = false;
  bool get searchToggle => _searchToggle;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  late ContactUser _selectedContactUser;
  ContactUser get selectedContactUser => _selectedContactUser;

  int _selectedContactId = 0;
  int get selectedContactId => _selectedContactId;

  void setTabIndex(int value) {
    _tabIndex = value;
    notifyListeners();
  }

  fetchContactData() async {
    try {
      if (await test.refreshSession()) {
        Response response = await _contactController
            .fetchContactData(test.token.accessToken!.bearerToken!);

        if (response.statusCode == 200) {
          List<dynamic> parsed = json.decode(response.body) as List;
          _contactList.clear();
          _contactList =
              parsed.map((val) => ContactUser.fromJson(val)).toList();

          _searchList.clear();
          _searchList.addAll(_contactList);

          notifyListeners();
        }
      }
    } on Exception catch (_) {}
  }

  fetchFavoriteData() async {
    try {
      if (await test.refreshSession()) {
        Response response = await _contactController
            .fetchFavoriteList(test.token.accessToken!.bearerToken!);

        if (response.statusCode == 200) {
          List<dynamic> parsed = json.decode(response.body) as List;
          _favoriteList.clear();
          _favoriteList =
              parsed.map((val) => ContactUser.fromJson(val)).toList();
          _searchFavoriteList.clear();
          _searchFavoriteList.addAll(_favoriteList);

          notifyListeners();
        }
      }
    } on Exception catch (_) {}
  }

  fetchBoardmemberData() async {
    try {
      if (await test.refreshSession()) {
        Response response = await _contactController
            .fetchBoardmemberList(test.token.accessToken!.bearerToken!);

        if (response.statusCode == 200) {
          List<dynamic> parsed = json.decode(response.body) as List;
          _boardList.clear();
          _boardList = parsed.map((val) => ContactUser.fromJson(val)).toList();

          _searchListBoards.clear();
          _searchListBoards.addAll(_boardList);

          notifyListeners();
        }
      }
    } on Exception catch (_) {}
  }

  fetchDataContactData() {
    fetchContactData();
    fetchFavoriteData();
    fetchBoardmemberData();
  }

  Future<ContactUser?> fetchSelectedUser() async {
    try {
      if (await test.refreshSession()) {
        Response response = await _contactController.getSelectedUser(
            test.token.accessToken!.bearerToken!, _selectedContactId);

        if (response.statusCode == 200) {
          _selectedContactUser =
              ContactUser.fromJson(json.decode(response.body));

          notifyListeners();
        }
      }
      return _selectedContactUser;
    } on Exception catch (_) {
      return null;
    }
  }

  addFavorite(ContactUser contact) async {
    if (!_searchFavoriteList.map((item) => item.id).contains(contact.id)) {
      _searchList
          .firstWhere((item) => item.id == contact.id)
          .updateIsFavorite(contact.isFavorite!);

      _searchFavoriteList.add(contact);

      if (contact.isBoardMember!) {
        _searchListBoards
            .firstWhere((item) => item.id == contact.id)
            .updateIsFavorite(contact.isFavorite!);

        _boardList
            .firstWhere((item) => item.id == contact.id)
            .updateIsFavorite(contact.isFavorite!);
      }

      notifyListeners();

      try {
        if (await test.refreshSession()) {
          await _contactController.addUserToFavorite(
              test.token.accessToken!.bearerToken!, contact.id!);
        }
      } on Exception catch (_) {}
    }
  }

  void removeFavoriteLocal(ContactUser contact) {
    _favoriteList.remove(contact);
    _searchFavoriteList.remove(contact);

    notifyListeners();

    if (contact.isBoardMember!) {
      _searchListBoards
          .firstWhere((item) => item.id == contact.id)
          .updateIsFavorite(false);

      _boardList
          .firstWhere((item) => item.id == contact.id)
          .updateIsFavorite(false);

      notifyListeners();
    }

    _searchList
        .firstWhere((item) => item.id == contact.id)
        .updateIsFavorite(false);

    _contactList
        .firstWhere((item) => item.id == contact.id)
        .updateIsFavorite(false);

    notifyListeners();
  }

  removeFavorite(ContactUser contact) async {
    try {
      if (await test.refreshSession()) {
        await _contactController.removeUserFromFavorite(
            test.token.accessToken!.bearerToken!, contact.id!);
      }
    } on Exception catch (_) {}
  }

  void filterSearchResults(
      List<ContactUser> list, String query, ListType type) {
    var searchLower = query.toLowerCase();
    list.clear();
    switch (type) {
      case ListType.contactList:
        list.addAll(_contactList);
        break;
      case ListType.favoriteList:
        list.addAll(_favoriteList);
        break;
      case ListType.boardmemberList:
        list.addAll(_boardList);
        break;
    }
    if (query.isNotEmpty) {
      List<ContactUser> dummyListData = [];

      list.forEach((item) {
        if (item.companyName != null &&
            item.companyName!.toLowerCase().contains(searchLower)) {
          dummyListData.add(item);
        } else if (test.fullName(
                    item.firstName, item.insertion, item.lastName) !=
                null &&
            test
                .fullName(item.firstName, item.insertion, item.lastName)
                .toLowerCase()
                .contains(searchLower)) {
          dummyListData.add(item);
        }
      });

      list.clear();
      list.addAll(dummyListData);
      notifyListeners();
      return;
    } else {
      list.clear();

      switch (type) {
        case ListType.contactList:
          list.addAll(_contactList);
          break;
        case ListType.favoriteList:
          list.addAll(_favoriteList);
          break;
        case ListType.boardmemberList:
          list.addAll(_boardList);
          break;
      }

      notifyListeners();
    }
  }

  resetSearch() {
    _searchList.clear();
    _searchList.addAll(_contactList);

    _searchListBoards.clear();
    _searchListBoards.addAll(_boardList);

    _searchFavoriteList.clear();
    _searchFavoriteList.addAll(_favoriteList);

    notifyListeners();
  }

  // setSelectedContactModel(ContactUser contact) {
  //   _selectedContactUser = contact;
  //   notifyListeners();
  // }

  setContactId(int id) {
    _selectedContactId = id;

    notifyListeners();
  }

  Future<bool> saveProfileData() async {
    notifyListeners();

    try {
      if (await test.refreshSession()) {
        Response result = await _contactController.saveContactUserData(
            _selectedContactUser.toJson(),
            test.token.accessToken!.bearerToken!,
            _selectedContactUser.id!);

        if (result.statusCode == 204 || result.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  toggleSearch() {
    _searchToggle = !_searchToggle;

    resetSearch();
    notifyListeners();
  }

  disposeSearch() {
    _searchToggle = false;
    resetSearch();
    notifyListeners();
  }

  @override
  void dispose() {
    _boardList.clear();
    _searchFavoriteList.clear();
    _searchListBoards.clear();

    _boardList.clear();
    _contactList.clear();
    _searchList.clear();

    super.dispose();
  }
}
