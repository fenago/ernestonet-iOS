import 'package:flutter/material.dart';

import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';

class ListPrice extends StatelessWidget {
  final Course course;

  const ListPrice({Key key, @required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return course.enrolled
        ? _buildEnrolledFreeText(context, 'Enrolled')
        : course.type != 'paid'
            ? _buildEnrolledFreeText(context, 'Free')
            : Row(
                children: <Widget>[
                  Text(
                    '${course.currency.symbol} ${course.discountPrice}',
                    style: context.textTheme().subtitle2.copyWith(fontSize: 14.0),
                  ),
                  UIHelper.horizontalSpaceSmall(),
                  Text(
                    '${course.currency.symbol} ${course.price}',
                    style: context.textTheme().subtitle1.copyWith(fontSize: 11.0, color: Colors.grey[600], decoration: TextDecoration.lineThrough),
                  )
                ],
              );
  }

  Text _buildEnrolledFreeText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme().subtitle2.copyWith(fontSize: 14.0),
    );
  }
}
