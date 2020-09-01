import 'package:cached_network_image/cached_network_image.dart';
import 'package:edustar/core/constants/app_barrel.dart';
import 'package:edustar/core/repositories/course/course_repository.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/core/view_models/search_course_list_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/models/course/search_course.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';

class SearchCourseListPage extends StatefulWidget {
  final List<SearchCourse> courses;

  const SearchCourseListPage({
    Key key,
    @required this.courses,
  }) : super(key: key);

  @override
  _SearchCourseListPageState createState() => _SearchCourseListPageState();
}

class _SearchCourseListPageState extends State<SearchCourseListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.courses.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => BaseView<SearchCourseListItemViewModel>(
        model: SearchCourseListItemViewModel(courseRepository: CourseRepository()),
        builder: (context, model, _) => SearchCourseListItem(
          course: widget.courses[index],
          busy: model.state == ViewState.busy,
          onPressed: () async {
            await model.getSearchDetailCourse(widget.courses[index].id);
            if (model.searchCourse != null) {
              if (model.searchCourse.enrolled) {
                Navigator.pushNamed(context, ViewRoutes.purchaseCourseDetail, arguments: model.searchCourse);
              } else {
                Navigator.pushNamed(context, ViewRoutes.courseDetail, arguments: model.searchCourse);
              }
            }
          },
        ),
      ),
    );
  }
}

class SearchCourseListItem extends StatelessWidget {
  final SearchCourse course;
  final VoidCallback onPressed;
  final bool busy;

  const SearchCourseListItem({
    Key key,
    @required this.course,
    @required this.onPressed,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: busy ? null : onPressed,
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
                  _ListRating(course: course),
                  _ListPrice(course: course),
                ],
              ),
            ),
            if (busy)
              SizedBox(
                child: CircularProgressIndicator(),
                height: 20.0,
                width: 20.0,
              ).paddingHorizontal(10.0)
          ],
        ),
      ),
    );
  }
}

class _ListRating extends StatelessWidget {
  final SearchCourse course;

  const _ListRating({Key key, @required this.course}) : super(key: key);

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
              initialRating: course?.avgRating ?? 0.0,
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

class _ListPrice extends StatelessWidget {
  final SearchCourse course;

  const _ListPrice({Key key, @required this.course}) : super(key: key);

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
