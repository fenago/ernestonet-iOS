import 'package:edustar/core/models/course/course.dart';
import 'package:flutter/foundation.dart';

import '../exceptions/repository_exception.dart';
import '../repositories/course/course_repository.dart';
import 'base_view_model.dart';
import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../models/course/search_course.dart';

class SearchCourseListItemViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  Course _searchCourses;

  Course get searchCourse => _searchCourses;

  SearchCourseListItemViewModel({
    @required courseRepository,
  }) : _courseRepository = courseRepository;

  void setSearchDetailCourse(Course course) {
    _searchCourses = course;
    notifyListeners();
  }

  Future<void> getSearchDetailCourse(int id) async {
    setState(ViewState.busy);
    try {
      final searchCourses = await _courseRepository.getCourseWithId(id);
      setSearchDetailCourse(searchCourses);
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      alert_helper.showAlert(e.message);
    } finally {
      setState(ViewState.idle);
    }
  }
}
