import 'package:flutter/foundation.dart';

import '../../locator.dart';
import '../exceptions/repository_exception.dart';
import '../models/course/course.dart';
import '../repositories/course/course_repository.dart';
import '../services/local_storage_service.dart';
import 'base_view_model.dart';

class CourseCategoryListViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  List<Course> _categoryCourses = [];
  int pageNo = 1;

  List<Course> get categoryCourses => _categoryCourses;

  CourseCategoryListViewModel({@required courseRepository}) : _courseRepository = courseRepository;

  void setCategoryCourses(List<Course> courses) {
    if (courses.isNotEmpty) {
      _categoryCourses.addAll(courses);
      pageNo = pageNo + 1;
    }
    notifyListeners();
  }

  Future<void> getCategoryBasedCourses(int categoryId) async {
    setState(ViewState.busy);
    try {
      final localStorageService = locator<LocalStorageService>();
      final categoryCourses = await _courseRepository.getAllCategoryBasedCourses(categoryId, pageNo, localStorageService.user.id);
      setCategoryCourses(categoryCourses);
      setState(ViewState.idle);
    } on RepositoryException {
      setState(ViewState.error);
    }
  }
}
