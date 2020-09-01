import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';
import 'list_price.dart';
import 'list_rating.dart';

class CourseCardItem extends StatelessWidget {
  final Course course;
  final double cardWidth;
  final double imageHeight;

  const CourseCardItem({
    Key key,
    @required this.course,
    @required this.cardWidth,
    @required this.imageHeight,
  })  : assert(course != null, 'Course should not be null. Please pass the course object in the argument of course parameter'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (course.enrolled) {
          Navigator.pushNamed(context, ViewRoutes.purchaseCourseDetail, arguments: course);
        } else {
          Navigator.pushNamed(context, ViewRoutes.courseDetail, arguments: course);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, right: 15.0, bottom: 10.0),
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                height: imageHeight,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: CachedNetworkImage(
                    imageUrl: (course.image != null) ? course.image : AssetImages.course,
                    placeholder: (context, url) => Image.asset(AssetImages.largeLoader, fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Text(
              course.title,
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
            ListRating(course: course),
            ListPrice(course: course),
          ],
        ),
      ),
    );
  }
}
