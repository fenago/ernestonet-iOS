import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_routes.dart';
import '../../../core/constants/asset_images.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';
import '../../../core/extensions/theme_x.dart';
import 'list_price.dart';
import 'list_rating.dart';

class CourseListItem extends StatelessWidget {
  final Course course;
  final double listHeight;

  const CourseListItem({Key key, @required this.course, this.listHeight = 100.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: listHeight,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CachedNetworkImage(
                    imageUrl: (course.image != null) ? course.image : ApiRoutes.mediaBaseUrl,
                    placeholder: (context, url) => Image.asset(AssetImages.largeLoader, fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  height: 90.0,
                  width: 100.0,
                ),
                UIHelper.horizontalSpaceSmall(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          course.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: context.textTheme().bodyText2.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        course.author.name,
                        style: context.textTheme().bodyText2.copyWith(color: Colors.grey[700]),
                      ),
                      ListRating(course: course),
                      ListPrice(course: course),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
