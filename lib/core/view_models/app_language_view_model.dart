import 'package:flutter/material.dart';

import '../../localization_setup.dart';
import '../../locator.dart';
import '../services/local_storage_service.dart';
import 'base_view_model.dart';

enum AppLanguageType {
  english,
  tamil,
  arabic,
}

class AppLanguageViewModel extends BaseViewModel {
  final localStorageService = locator<LocalStorageService>();
  Locale _appLocale = supportedLocales.first;

  Locale get appLocale => _appLocale;

  AppLanguageViewModel() {
    fetchLocale();
  }

  void updateLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }

  void fetchLocale() async {
    print('Local Storage Locale : ${localStorageService.languageCode}');
    if (localStorageService.languageCode == null) {
      updateLocale(supportedLocales.first);
      return null;
    }
    _appLocale = Locale(localStorageService.languageCode);
    return null;
  }

  void changeLanguage(AppLanguageType appLanguageType) {
    switch (appLanguageType) {
      case AppLanguageType.english:
        localStorageService.languageCode = 'en';
        localStorageService.countryCode = 'US';
        updateLocale(supportedLocales[0]);
        break;
      case AppLanguageType.tamil:
        localStorageService.languageCode = 'ta';
        localStorageService.countryCode = 'IN';
        updateLocale(supportedLocales[1]);
        break;
      case AppLanguageType.arabic:
        localStorageService.languageCode = 'ar';
        localStorageService.countryCode = '';
        updateLocale(supportedLocales[2]);
        break;
    }
    notifyListeners();
  }
}
