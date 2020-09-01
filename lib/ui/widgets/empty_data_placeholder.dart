import 'package:flutter/material.dart';

import '../../core/extensions/media_query_x.dart';
import '../../core/extensions/theme_x.dart';
import '../shared/ui_helper.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String title;
  final String image;

  const EmptyPlaceholder({Key key, @required this.title, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image,
          width: context.mediaQuerySize().width / 1,
          height: context.mediaQuerySize().width / 2,
        ),
        UIHelper.verticalSpaceMedium(),
        Text(title, style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.w400)),
      ],
    ));
  }
}
