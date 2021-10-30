import 'dart:convert';
import 'package:base/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  const LocalStorage(this.sharedPreferences);

  final String _sessionKey = "TOKEN";
  final String _emailKey = "EMAIL";

  final SharedPreferences sharedPreferences;

  saveSession(Token auth) async {
    try {
      await sharedPreferences.setString(_sessionKey, json.encode(auth));
      print('opslaan ging goed');
      print(auth);
    } catch (_) {
      print('het ging niet goed' + _.toString());
    }
  }

  saveEmail(String email) async {
    await sharedPreferences.setString(_emailKey, email);
  }

  getEmail() async {
    return sharedPreferences.get(_emailKey) ?? null;
  }

  clearSession() async {
    return sharedPreferences.remove(_sessionKey);
  }

  dynamic getSession() {
    Map<String, dynamic> userSession = Map<String, dynamic>();
    String storedSession = sharedPreferences.getString(_sessionKey) ?? '';
    print('user wordt opgehaald');
    try {
      if (storedSession.isNotEmpty) {
        userSession = jsonDecode(storedSession);
      }

      if (userSession.isNotEmpty) {
        Token userToken = Token.fromJson(userSession);

        return userToken;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
