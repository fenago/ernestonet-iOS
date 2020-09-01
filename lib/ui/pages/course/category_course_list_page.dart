import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/ui/shared/app_style.dart';
import 'package:flutter/material.dart';

import '../../../core/repositories/course/course_repository.dart';
import '../../../core/view_models/course_category_list_view_model.dart';
import '../../widgets/course/category_course_search_list_item.dart';
import '../../widgets/pagination_loader.dart';
import '../base_view.dart';
import 'course_list_shimmer_page.dart';

class CategoryCourseListPage extends StatefulWidget {
  final int categoryId;

  const CategoryCourseListPage({Key key, @required this.categoryId}) : super(key: key);

  @override
  _CategoryCourseListPageState createState() => _CategoryCourseListPageState();
}

class _CategoryCourseListPageState extends State<CategoryCourseListPage> {
  bool isFirstTime = true;
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseCategoryListViewModel>(
      model: CourseCategoryListViewModel(courseRepository: CourseRepository()),
      onModelReady: (model) => model.getCategoryBasedCourses(widget.categoryId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Flutter development', style: appBarTheme),
          //TODO: Hidden actions temporarily
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 10.0),
          //     child: IconButton(
          //       icon: Icon(Icons.filter_list),
          //       onPressed: () => showModalBottomSheet(
          //         context: context,
          //         isScrollControlled: true,
          //         builder: (BuildContext context) => SizedBox(
          //           height: context.mediaQuerySize().width / 0.7,
          //           child: SortFilterPage(),
          //         ),
          //       ),
          //     ),
          //   ),
          //   CartBadgeIcon(),
          // ],
        ),
        body: (model.state == ViewState.busy && isFirstTime)
            ? getShimmerView()
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    print('Reached end');
                    pageNo = pageNo + 1;
                    model.getCategoryBasedCourses(widget.categoryId);
                  } else {
                    print('Scrolling...');
                  }
                  return false;
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                        itemCount: model.categoryCourses.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) => CategoryCourseSearchListItem(
                          course: model.categoryCourses[index],
                          onPressed: () {},
                        ),
                      ),
                    ),
                    (model.state == ViewState.busy) ? PaginationLoader() : SizedBox()
                  ],
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
