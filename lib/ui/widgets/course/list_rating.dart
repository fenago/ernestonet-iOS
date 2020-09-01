import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/extensions/theme_x.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';

class ListRating extends StatelessWidget {
  final Course course;

  const ListRating({Key key, @required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle bodyText = context.textTheme().bodyText2.copyWith(
          fontSize: 12.0,
        );

    return SizedBox(
      height: 22.0,
      child: Row(
        children: <Widget>[
          IgnorePointer(
            child: RatingBar(
              itemSize: 18.0,
              initialRating: course.avgRating,
              minRating: 1,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          UIHelper.horizontalSpaceExtraSmall(),
          Text(
            '${course?.avgRating}',
            style: bodyText,
          ),
          UIHelper.horizontalSpaceExtraSmall(),
          Text(
            '(${course.reviews?.length ?? 0})',
            style: bodyText.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
