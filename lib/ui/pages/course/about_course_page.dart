import 'package:flutter/material.dart';

import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../shared/app_style.dart';

class AboutCoursePage extends StatelessWidget {
  final String aboutDesc;

  AboutCoursePage({Key key, @required this.aboutDesc})
      : assert(aboutDesc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.aboutThisCourse, style: appBarTheme),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(aboutDesc, style: context.textTheme().bodyText1),
          ),
        ),
      ),
    );
  }
}
