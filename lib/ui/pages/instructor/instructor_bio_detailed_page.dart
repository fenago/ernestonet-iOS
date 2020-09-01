import 'package:edustar/core/localization/app_localizations.dart';
import 'package:edustar/ui/shared/app_style.dart';
import 'package:flutter/material.dart';

class InstructorBioDetailedPage extends StatelessWidget {
  final String bio;

  const InstructorBioDetailedPage({
    Key key,
    @required this.bio,
  })  : assert(bio != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(locale.aboutInstructorNavTitle, style: appBarTheme)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(bio),
          ),
        ),
      ),
    );
  }
}
