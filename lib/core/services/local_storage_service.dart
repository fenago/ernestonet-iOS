import 'dart:convert';

import 'package:edustar/core/constants/local_storage_keys.dart';
import 'package:edustar/core/models/landing.dart';
import 'package:edustar/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  bool get loggedIn => _getFromDisk(LocalStorageKeys.loginStatus) ?? false;
  bool get darkMode => _getFromDisk(LocalStorageKeys.darkMode) ?? false;
  bool get onboard => _getFromDisk(LocalStorageKeys.onboard) ?? true;
  String get languageCode => _getFromDisk(LocalStorageKeys.languageCode) ?? null;
  String get countryCode => _getFromDisk(LocalStorageKeys.countryCode) ?? null;
  User get user {
    var userJson = _getFromDisk(LocalStorageKeys.user);
    if (userJson == null) {
      return null;
    }
    return User.fromJson(jsonDecode(userJson));
  }

  Landing get landing {
    var landingJson = _getFromDisk(LocalStorageKeys.landing);
    if (landingJson == null) {
      return null;
    }
    return Landing.fromJson(jsonDecode(landingJson));
  }

  set loggedIn(bool value) => _saveToDisk(LocalStorageKeys.loginStatus, value);
  set darkMode(bool value) => _saveToDisk(LocalStorageKeys.darkMode, value);
  set onboard(bool value) => _saveToDisk(LocalStorageKeys.onboard, value);
  set languageCode(String code) => _saveToDisk(LocalStorageKeys.languageCode, code);
  set countryCode(String code) => _saveToDisk(LocalStorageKeys.countryCode, code);
  set user(User user) {
    if (user == null) {
      _removeFromDisk(LocalStorageKeys.user);
    } else {
      _saveToDisk(LocalStorageKeys.user, jsonEncode(user.toJson()));
    }
  }

  set landing(Landing landing) {
    if (landing == null) {
      _removeFromDisk(LocalStorageKeys.landing);
    } else {
      _saveToDisk(LocalStorageKeys.landing, jsonEncode(landing.toJson()));
    }
  }

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('LocalStorageService: Get -> key: $key');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    print('LocalStorageService: Save -> key: $key value: $content');
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  void _removeFromDisk(String key) {
    _preferences.remove(key);
  }
}
