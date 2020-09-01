import 'package:edustar/core/exceptions/repository_exception.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:edustar/core/repositories/course/course_repository.dart';
import 'package:flutter/foundation.dart';

import 'base_view_model.dart';

class PurchaseCourseRootDetailViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  Course _course;

  Course get course => _course;

  PurchaseCourseRootDetailViewModel({
    @required courseRepository,
  }) : _courseRepository = courseRepository;

  void setCourse(Course course) {
    _course = course;
    notifyListeners();
  }

  Future<void> getCourseDetail(int id) async {
    try {
      setState(ViewState.idle);
      final course = await _courseRepository.courseDetail(id);
      setCourse(course);
    } on RepositoryException {
      setState(ViewState.error);
      setState(ViewState.idle);
    }
  }
}
