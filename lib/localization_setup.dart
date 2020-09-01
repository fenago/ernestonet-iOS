import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/app_localizations.dart';

const supportedLocaleCodes = ['en', 'ta', 'ar'];

final List<Locale> supportedLocales = supportedLocaleCodes
    .map(
      (code) => Locale.fromSubtags(languageCode: code),
    )
    .toList();

List<LocalizationsDelegate> get localizationsDelegate {
  return [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

/// Returns a locale which will be used by the app
Locale loadSupportedLocales(Locale locale, Iterable<Locale> supportedLocales) {
  // Check if current device locale is supported
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }
  // If the locale is not supported by device, then return the default locale (english, en)
  return supportedLocales.first;
}