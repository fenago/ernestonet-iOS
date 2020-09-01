import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';
import 'list_price.dart';
import 'list_rating.dart';

class CategoryCourseSearchListItem extends StatelessWidget {
  final Course course;
  final VoidCallback onPressed;

  const CategoryCourseSearchListItem({
    Key key,
    @required this.course,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              height: 60.0,
              width: 60.0,
              imageUrl: (course.image != null) ? course.image : AssetImages.course,
              placeholder: (context, url) => Image.asset(AssetImages.largeLoader, fit: BoxFit.cover, height: 60.0, width: 60.0),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            UIHelper.horizontalSpaceSmall(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    course.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textTheme().bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  ListRating(course: course),
                  ListPrice(course: course),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
