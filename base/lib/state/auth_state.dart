import 'dart:async';
import 'dart:convert';
import 'package:base/helper/shared_preference.dart';
import 'package:base/models/app_user.dart';
import 'package:base/models/error.dart';
import 'package:base/models/token.dart';
import 'package:base/repository/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum AppState {
  authenticated,
  authenticating,
  unauthenticated,
  initial,
}

class AuthState with ChangeNotifier {
  final AuthController _authController = AuthController();

  AppState get appState => _appState;

  AppState _appState = AppState.initial;

  bool loading = false;

  late String _username, _password;
  String get username => _username;
  String get password => _password;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  late AppUser _appUser;

  AppUser get appUser => _appUser;

  ErrorMessage get errorMsg => _errorMessage;
  late ErrorMessage _errorMessage;

  Token get token => _token;
  late Token _token;

  final LocalStorage localStorage;

  AuthState(this.localStorage);

  Future<bool> refreshSession() async {
    try {
      _token = await localStorage.getSession();
      //  var _email = await localStorage.getEmail();
      if (DateTime.now().millisecondsSinceEpoch / 1000 >
          _token.accessToken!.expiryDate!) {
        //hier moet refresh token worden aangevraagd
        Map<String, dynamic> loginForm = {
          'refreshToken': _token.refreshToken!.bearerToken,
          //  'emailAddress': _email
        };
        Response response = await _authController.refreshSession(loginForm);

        if (response.statusCode == 200) {
          _token = Token.fromJson(json.decode(response.body));
          localStorage.saveSession(_token);
          print('er is een nieuwe token opgeslagen');
          notifyListeners();
        }
      } else {
        //hier hoeft geen nieuwe token worden aangevraagd
        print('er is geen nieuwe token nodig');
      }

      print(_token.accessToken!.bearerToken);
      return true;
    } catch (_) {
      disconnect();

      return false;
    }
  }

  Future<AppUser?> checkConnection() async {
    try {
      if (await refreshSession()) {
        _token = await localStorage.getSession();

        Response response = await _authController
            .checkAndSetSession(_token.accessToken!.bearerToken!);

        if (response.statusCode == 200) {
          _appUser = AppUser.fromJson(json.decode(response.body));

          notifyListeners();
        }
      }

      return _appUser;
    } catch (_) {
      return null;
    }
  }

  fullName(first, middle, last) {
    String firstName = first ?? '';
    String middleName = middle ?? '';
    String lastName = last ?? '';
    String fullname = firstName.trim() +
        " " +
        (middleName.isEmpty ? '' : middleName.trim() + " ") +
        lastName.trim();

    return fullname;
  }

  disconnect() async {
    await localStorage.clearSession();

    _appState = AppState.unauthenticated;
    notifyListeners();
  }

  Future<dynamic> login(String username, String password) async {
    var loginForm = {'emailAddress': username, 'password': password};

    loading = true;
    notifyListeners();

    try {
      Response response = await _authController.login(loginForm);

      if (response.statusCode == 200) {
        _token = Token.fromJson(json.decode(response.body));
        await localStorage.saveSession(_token);
        await localStorage.saveEmail(username);
        _appState = AppState.authenticating;
        loading = false;
        notifyListeners();
      }
      return response.statusCode;
    } on Exception catch (_) {
      loading = false;
      notifyListeners();

      return _.toString();
    }
  }

  logout() {
    _appState = AppState.unauthenticated;
    notifyListeners();
  }

  setInitial() {
    _appState = AppState.initial;
    notifyListeners();
  }

  setAuthenticated() {
    _appState = AppState.authenticated;
    notifyListeners();
  }

  setUnauthenticated() {
    _appState = AppState.unauthenticated;
    notifyListeners();
  }

  setAuthenticating() {
    _appState = AppState.authenticating;
    notifyListeners();
  }
}
