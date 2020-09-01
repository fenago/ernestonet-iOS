import 'package:flutter/material.dart';

import '../../../core/models/course_category.dart';
import 'course_card_item.dart';
import 'course_card_title.dart';

class CourseLargeList extends StatelessWidget {
  final CourseCategory courseCategory;
  final double cardListViewHeight;

  const CourseLargeList({
    Key key,
    @required this.courseCategory,
    this.cardListViewHeight = 292.0,
  })  : assert(courseCategory != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardListViewHeight,
      child: Column(
        children: <Widget>[
          CourseCardTitle(title: courseCategory.title),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courseCategory.courses.length,
              itemBuilder: (context, index) => CourseCardItem(
                course: courseCategory.courses[index],
                cardWidth: 250.0,
                imageHeight: 140.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
