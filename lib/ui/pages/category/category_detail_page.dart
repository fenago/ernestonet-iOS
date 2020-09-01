import 'dart:io';

import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/media_query_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/view_models/course_category_list_view_model.dart';
import '../../widgets/course/course_list_item.dart';
import '../../widgets/empty_data_placeholder.dart';
import '../../widgets/pagination_loader.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';
import '../course/course_list_shimmer_page.dart';

class CategoryDetailPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryDetailPage({
    Key key,
    @required this.categoryId,
    @required this.categoryName,
  }) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  bool isFirstTime = true;
  bool isIOS = false;
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    isIOS = Platform.isIOS;
    return Scaffold(
      appBar: isIOS
          ? AppBar(
              elevation: 0.0,
              actions: <Widget>[
                //TODO - Hiddent filter temporarily
                // IconButton(
                //   icon: Icon(Icons.filter_list),
                //   onPressed: () => showModalBottomSheet(
                //     context: context,
                //     isScrollControlled: true,
                //     builder: (BuildContext context) => SizedBox(
                //       height: context.mediaQuerySize().width / 0.7,
                //       child: SortFilterPage(),
                //     ),
                //   ),
                // ),
              ],
            )
          : null,
      body: SafeArea(
        child: BaseView<CourseCategoryListViewModel>(
          model: CourseCategoryListViewModel(courseRepository: CourseRepository()),
          onModelReady: (model) => model.getCategoryBasedCourses(widget.categoryId),
          builder: (context, model, child) => NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                model.getCategoryBasedCourses(widget.categoryId);
              }
              return false;
            },
            child: (model.state == ViewState.busy && isFirstTime)
                ? SizedBox(height: context.mediaQuerySize().height, child: getShimmerView())
                : Padding(
                    padding: EdgeInsets.only(top: isIOS ? 10.0 : 20.0),
                    child: model.categoryCourses.isEmpty
                        ? EmptyPlaceholder(title: locale.emptyCourse, image: AssetImages.emptyCategoryCourse)
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _HeaderView(categoryName: widget.categoryName),
                              Flexible(
                                fit: FlexFit.loose,
                                child: SingleChildScrollView(
                                  child: _AllCourseView(model: model),
                                ),
                              )
                            ],
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  CourseListShimmerPage getShimmerView() {
    isFirstTime = false;
    return CourseListShimmerPage();
  }
}

class _HeaderView extends StatelessWidget {
  final String categoryName;

  const _HeaderView({Key key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(categoryName, style: context.textTheme().headline3.copyWith(fontSize: 25.0)),
          UIHelper.verticalSpaceMedium(),
          // TODO: - Disabled top instructor temporarily
          // Text('Top Instructor', style: context.textTheme().subtitle2),
          // _InstructorListView(),
          // UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}

class _InstructorListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      height: 280.0,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        childAspectRatio: 0.4,
        children: List.generate(15, (index) => _buildAuthorView(context)),
      ),
    );
  }

  Container _buildAuthorView(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 20.0, right: 20.0),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, ViewRoutes.instructorProfile),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipOval(child: Image.asset(AssetImages.largeLoader)),
              UIHelper.horizontalSpaceSmall(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Vinoth Vino',
                    style: context.textTheme().headline6,
                  ),
                  Text(
                    'Developer and Lead Instructor',
                    style: context.textTheme().bodyText2,
                  ),
                  Text(
                    '2149 students',
                    style: context.textTheme().bodyText2,
                  ),
                  Text(
                    '29 courses',
                    style: context.textTheme().bodyText2,
                  )
                ],
              )
            ],
          ),
        ),
      );
}

class _AllCourseView extends StatefulWidget {
  final CourseCategoryListViewModel model;

  const _AllCourseView({Key key, @required this.model}) : super(key: key);

  @override
  __AllCourseViewState createState() => __AllCourseViewState();
}

class __AllCourseViewState extends State<_AllCourseView> {
  bool isFirstTime = true;
  CourseCategoryListViewModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.categoryCourses.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (model.categoryCourses[index].enrolled) {
                  Navigator.pushNamed(context, ViewRoutes.purchaseCourseDetail, arguments: model.categoryCourses[index]);
                } else {
                  Navigator.pushNamed(context, ViewRoutes.courseDetail, arguments: model.categoryCourses[index]);
                }
              },
              child: CourseListItem(course: model.categoryCourses[index]),
            ),
          ),
          (model.state == ViewState.busy) ? PaginationLoader() : SizedBox()
        ],
      ),
    );
  }

  CourseListShimmerPage getShimmerView() {
    isFirstTime = false;
    return CourseListShimmerPage();
  }
}
