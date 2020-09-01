import 'package:edustar/core/repositories/course/course_repository.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/core/view_models/search_course_view_model.dart';
import 'package:edustar/ui/pages/base_view.dart';
import 'package:edustar/ui/pages/search/search_course_list_page.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../shared/ui_helper.dart';

class SearchCategoryPage extends StatefulWidget {
  const SearchCategoryPage({Key key}) : super(key: key);

  @override
  _SearchCategoryPageState createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  TextEditingController _searchController;
  FocusNode _myFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BaseView<SearchCourseViewModel>(
      model: SearchCourseViewModel(courseRepository: CourseRepository()),
      builder: (_, model, __) => Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            focusNode: _myFocusNode,
            textInputAction: TextInputAction.search,
            maxLines: 1,
            autofocus: true,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: locale.searchPlaceholder,
              hintStyle: TextStyle(fontSize: 18.0),
            ),
            onChanged: (data) {
              searchCourses(model, data, isChanged: true);
            },
            onEditingComplete: () {
              searchCourses(model, _searchController.text);
            },
            onSubmitted: (data) {
              searchCourses(model, data);
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchCourses(model, _searchController.text);
                }),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: (model.state == ViewState.busy)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _searchController.text == '' ? SizedBox() : SearchCourseListPage(courses: model.searchCourses),
          ),
        ),
      ),
    );
  }

  void searchCourses(SearchCourseViewModel model, String query, {bool isChanged = false}) {
    if (!isChanged) {
      FocusScope.of(context).unfocus();
    }
    if (query.isNotEmpty && query != null) {
      Future.delayed(Duration(milliseconds: isChanged ? 1500 : 500), () {
        model.getSearchCourses(query == null || query == '' ? '' : query);
      });
    }
  }
}
