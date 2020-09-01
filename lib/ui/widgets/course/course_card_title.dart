import 'package:flutter/material.dart';

import '../../../core/extensions/theme_x.dart';

class CourseCardTitle extends StatelessWidget {
  final String title;

  const CourseCardTitle({Key key, @required this.title})
      : assert(title != null || title != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40.0,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme().subtitle1.copyWith(fontSize: 17.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
