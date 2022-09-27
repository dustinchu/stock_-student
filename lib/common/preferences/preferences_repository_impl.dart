import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  static const String _accountCodeKey = 'stock';

  @override
  Future<String> getAccount() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(_accountCodeKey) ?? "");
  }

  @override
  Future<void> removeAccount() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_accountCodeKey);
  }

  @override
  Future<void> saveAccount(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_accountCodeKey, username);
  }

  Future<Map<String, dynamic>> getJson(String key,
      {Map<String, dynamic>? defaultValue}) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return json.decode(prefs.getString(key)!);
    } else {
      return defaultValue ?? {};
    }
  }

  Future<bool> setJsonStr(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}
