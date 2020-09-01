import 'package:flutter/foundation.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/repositories/course/course_repository.dart';
import '../../core/view_models/base_view_model.dart';
import '../models/course/search_course.dart';

class SearchCourseViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  List<SearchCourse> _searchCourses;

  List<SearchCourse> get searchCourses => _searchCourses;

  SearchCourseViewModel({@required courseRepository}) : _courseRepository = courseRepository;

  void setSearchCourse(List<SearchCourse> myCourse) {
    _searchCourses = myCourse;
    notifyListeners();
  }

  Future<void> getSearchCourses(String keyword) async {
    setState(ViewState.busy);
    try {
      final searchCourses = await _courseRepository.searchCourses(keyword);
      setSearchCourse(searchCourses);
    } on RepositoryException {
      setState(ViewState.error);
    } finally {
      setState(ViewState.idle);
    }
  }
}
