import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/choose_language.dart';
import '../../../core/view_models/app_language_view_model.dart';
import '../../shared/app_style.dart';

class ChooseLanguagePage extends StatefulWidget {
  @override
  _ChooseLanguagePageState createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  final List<ChooseLanguage> languages = [
    ChooseLanguage(title: 'English', languageCode: 'en', isSelected: false),
    ChooseLanguage(title: 'தமிழ்', languageCode: 'ta', isSelected: false),
    ChooseLanguage(title: 'عربى', languageCode: 'ar', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    updateCurrentLanguage(locale);
    var appLanguage = Provider.of<AppLanguageViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.changeLanguage, style: appBarTheme),
      ),
      body: ListView.separated(
        itemCount: languages.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text(languages[index].title),
          trailing: languages[index].isSelected ? Icon(Icons.check, color: context.theme().accentColor) : SizedBox(),
          dense: true,
          onTap: () {
            switch (index) {
              case 0:
                appLanguage.changeLanguage(AppLanguageType.english);
                break;
              case 1:
                appLanguage.changeLanguage(AppLanguageType.tamil);
                break;
              default:
                appLanguage.changeLanguage(AppLanguageType.arabic);
            }
            updateCurrentLanguage(AppLocalizations.of(context));
          },
        ),
      ),
    );
  }

  void updateCurrentLanguage(AppLocalizations appLocalizations) {
    languages.forEach((language) {
      if (appLocalizations.locale.languageCode == language.languageCode) {
        language.isSelected = true;
      } else {
        language.isSelected = false;
      }
    });
    setState(() {});
  }
}
