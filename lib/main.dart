import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_barrel.dart';
import 'core/localization/app_localizations.dart';
import 'core/managers/dialog_manager.dart';
import 'core/managers/lifecycle_manager.dart';
import 'core/services/local_storage_service.dart';
import 'core/utils/file_helper.dart';
import 'core/view_models/app_language_view_model.dart';
import 'core/view_models/dark_mode_view_model.dart';
import 'core/view_models/home_bottom_navigation_view_model.dart';
import 'localization_setup.dart';
import 'locator.dart';
import 'provider_setup.dart';
import 'router.dart';
import 'ui/shared/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final darkMode = locator<LocalStorageService>().darkMode;
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
  //   systemNavigationBarColor: darkMode ? Colors.grey[900] : Colors.white,
  //   statusBarColor: darkMode ? Colors.grey[900] : Colors.white,
  // ));
  final fileHelper = locator<FileHelper>();
  Hive.init(await fileHelper.getApplicationDocumentsDirectoryPath());
  runApp(
    DevicePreview(
      enabled: false,
      areSettingsEnabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: LifeCycleManager(
        child: Consumer3<AppLanguageViewModel, DarkThemeViewModel, HomeBottomNavigationViewModel>(builder: (context, appLanguageModel, darkThemeModel, _, child) {
          return MaterialApp(
            title: Constant.appTitle,
            debugShowCheckedModeBanner: false,
            theme: darkThemeModel.darkTheme ? appDarkTheme() : appPrimaryTheme(),
            localizationsDelegates: localizationsDelegate,
            supportedLocales: supportedLocales,
            locale: appLanguageModel.appLocale,
            initialRoute: ViewRoutes.initial,
            onGenerateRoute: Router.generateRoutes,
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                  child: widget,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
