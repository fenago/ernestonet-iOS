import 'package:flutter/foundation.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/models/course/course.dart';
import '../../core/repositories/course/course_repository.dart';
import '../../core/view_models/base_view_model.dart';

class MyCourseViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  List<Course> _myCourses;
  int page = 1;

  List<Course> get myCourses => _myCourses;

  MyCourseViewModel({@required courseRepository}) : _courseRepository = courseRepository;

  void _setMyCourse(List<Course> myCourse) {
    _myCourses = myCourse;
    notifyListeners();
  }

  void updatePageNo(int value) {
    page = value;
  }

  Future<void> getMyCourses(int pageNo) async {
    setState(ViewState.busy);
    try {
      final myCourses = await _courseRepository.getAllMyCourses(pageNo, (refreshedMyCourses) {
        _setMyCourse(refreshedMyCourses);
      });
      _setMyCourse(myCourses);
    } on RepositoryException {
      setState(ViewState.error);
    } finally {
      setState(ViewState.idle);
    }
  }
}
