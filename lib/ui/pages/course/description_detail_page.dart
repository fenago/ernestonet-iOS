import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/extensions/theme_x.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';

class DescriptionDetailPage extends StatelessWidget {
  final String title;
  final String aboutDesc;

  const DescriptionDetailPage({Key key, @required this.title, @required this.aboutDesc})
      : assert(title != null, aboutDesc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: appBarTheme),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              aboutDesc,
              style: context.textTheme().bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
