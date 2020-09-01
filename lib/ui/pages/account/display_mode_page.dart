import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/dark_mode_view_model.dart';
import '../../../locator.dart';
import '../../shared/app_style.dart';

class DisplayModePage extends StatefulWidget {
  @override
  _DisplayModePageState createState() => _DisplayModePageState();
}

class _DisplayModePageState extends State<DisplayModePage> {
  List<String> modes;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final localStorageService = locator<LocalStorageService>();
    final darkModeViewModel = context.watch<DarkThemeViewModel>();

    modes = [locale.light, locale.dark];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.displayMode,
          style: appBarTheme,
        ),
      ),
      body: ListView.separated(
        itemCount: modes.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text(modes[index], style: context.textTheme().bodyText1),
          trailing: _trailingWidget(index),
          dense: true,
          onTap: () {
            switch (index) {
              case 0:
                darkModeViewModel.setDarkTheme = false;
                localStorageService.darkMode = false;
                break;
              default:
                darkModeViewModel.setDarkTheme = true;
                localStorageService.darkMode = true;
            }
            final darkMode = locator<LocalStorageService>().darkMode;
            // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            //   systemNavigationBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
            //   systemNavigationBarColor: darkMode ? Colors.grey[900] : Colors.white,
            //   statusBarColor: darkMode ? Colors.grey[900] : Colors.white,
            // ));
          },
        ),
      ),
    );
  }

  Widget _trailingWidget(int index) {
    final localStorageService = locator<LocalStorageService>();
    if (localStorageService.darkMode) {
      if (index == 1) {
        return Icon(Icons.check, color: context.theme().accentColor);
      } else {
        return SizedBox();
      }
    } else {
      if (index == 0) {
        return Icon(Icons.check, color: context.theme().accentColor);
      } else {
        return SizedBox();
      }
    }
  }
}
