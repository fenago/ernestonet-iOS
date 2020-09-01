import 'package:edustar/core/view_models/cart_badge_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/view_models/my_course_view_model.dart';
import '../../widgets/course/my_course_list_item.dart';
import '../base_view.dart';
import '../course/course_list_shimmer_page.dart';
import '../../widgets/cart_badge_icon.dart';
import '../../widgets/course/course_wishlist_empty.dart';
import '../../../core/extensions/theme_x.dart';

class MyCoursePage extends StatefulWidget {
  @override
  _MyCoursePageState createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BaseView<MyCourseViewModel>(
      model: MyCourseViewModel(
        courseRepository: CourseRepository(),
      ),
      onModelReady: (model) => model.getMyCourses(1),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text(
            locale.myCourseNavTitle,
            style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            CartBadgeIcon(
              onPressed: () async {
                final isPopped = await Navigator.pushNamed(context, ViewRoutes.cart);
                if (isPopped) {
                  await context.read<CartBadgeViewModel>().getCartCourses();
                  print('isPopped : $isPopped');
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: (model.myCourses == null)
              ? CourseListShimmerPage()
              : (model.myCourses.isEmpty)
                  ? CourseWishlistEmpty(
                      emptyImage: AssetImages.emptyCourse,
                      title: locale.emptyCourse,
                      buttonTitle: locale.buyCourse,
                    )
                  : Container(
                      alignment: Alignment.center,
                      color: context.theme().scaffoldBackgroundColor,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: MyCourseList(
                              model: model,
                              myCourses: model.myCourses,
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class MyCourseList extends StatefulWidget {
  final MyCourseViewModel model;
  final List<Course> myCourses;

  const MyCourseList({Key key, @required this.model, @required this.myCourses}) : super(key: key);

  @override
  _MyCourseListState createState() => _MyCourseListState();
}

class _MyCourseListState extends State<MyCourseList> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          print('Reached end');
          widget.model.updatePageNo(widget.model.page + 1);
          widget.model.getMyCourses(widget.model.page);
        } else {
          print('Scrolling...');
        }
        return false;
      },
      child: ListView.separated(
        itemCount: widget.myCourses?.length ?? 0,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => InkWell(
          child: MyCourseListItem(
            course: widget.myCourses[index],
            percentage: 0.4,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              ViewRoutes.purchaseCourseDetail,
              arguments: widget.myCourses[index],
            );
          },
        ),
      ),
    );
  }
}
