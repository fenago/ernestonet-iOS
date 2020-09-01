import 'package:flutter/material.dart';

import '../../locator.dart';
import '../services/local_storage_service.dart';

class DarkThemeViewModel extends ChangeNotifier {
  final localStorage = locator<LocalStorageService>();
  bool _darkTheme = true;

  bool get darkTheme {
    _darkTheme = localStorage.darkMode;
    return _darkTheme;
  }

  set setDarkTheme(bool value) {
    _darkTheme = value;
    localStorage.darkMode = value;
    notifyListeners();
  }
}
