import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_routes.dart';
import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/models/course/course.dart';
import '../../shared/ui_helper.dart';

class MyCourseListItem extends StatelessWidget {
  final Course course;
  final double percentage;

  const MyCourseListItem({Key key, @required this.course, @required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final greyTextStyle = context.textTheme().bodyText2.copyWith(
          color: Colors.grey[700],
          fontSize: 12.0,
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 80.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
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
                          height: 80.0,
                          width: 100.0,
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  course?.title ?? 'Not found',
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
                                style: greyTextStyle,
                              ),
                              UIHelper.verticalSpaceExtraSmall(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
