import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/view_models/auth_view_model.dart';
import 'package:edustar/core/view_models/cart_badge_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/api_routes.dart';
import '../../../core/constants/asset_images.dart';
import '../../../core/constants/view_routes.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/models/course/course.dart';
import '../../../core/view_models/home_bottom_navigation_view_model.dart';
import '../../shared/ui_helper.dart';

class CourseEnrolledStartedPage extends StatelessWidget {
  final Course course;

  const CourseEnrolledStartedPage({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<CartBadgeViewModel>().updateCartCourseCount(0);
        context.read<HomeBottomNavigationViewModel>().setBottomBarIndex(0);
        Navigator.pushReplacementNamed(context, ViewRoutes.initial);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
              height: 180.0,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: CachedNetworkImage(
                            imageUrl: (course?.image != null) ? course.image : ApiRoutes.mediaBaseUrl + AssetImages.course,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                        UIHelper.horizontalSpaceMedium(),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('You are now enrolled in:', style: context.textTheme().subtitle1.copyWith(color: Colors.grey)),
                              UIHelper.verticalSpaceExtraSmall(),
                              Text(course.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textTheme().headline6),
                              UIHelper.verticalSpaceExtraSmall(),
                              Text(course.author.name, style: context.textTheme().bodyText2.copyWith(color: Colors.grey))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  FormSubmitButton(
                    title: 'GET STARTED',
                    borderRadius: 0.0,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ViewRoutes.purchaseCourseDetail,
                        arguments: course,
                      );
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
