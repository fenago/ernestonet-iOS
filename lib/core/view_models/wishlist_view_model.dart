import 'package:flutter/foundation.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/models/course/course.dart';
import '../../core/repositories/course/course_repository.dart';
import '../../core/view_models/base_view_model.dart';
import '../../locator.dart';
import '../services/local_storage_service.dart';

class WishlistViewModel extends BaseViewModel {
  final CourseRepository _courseRepository;
  final LocalStorageService localStorageService = locator<LocalStorageService>();

  List<Course> _myWishlistCourse;
  int page = 1;

  List<Course> get myWishlistCourse => _myWishlistCourse;

  WishlistViewModel({@required courseRepository}) : _courseRepository = courseRepository;

  void _setMyWishlistCourse(List<Course> myWishlistCourse) {
    _myWishlistCourse = myWishlistCourse;
    notifyListeners();
  }

  void updatePageNo(int value) {
    page = value;
  }

  Future<void> getAllWishlistCourses(int pageNo) async {
    setState(ViewState.busy);
    try {
      final wishlistCourses = await _courseRepository.getAllWishlistCourses(pageNo, (refreshedCourses) {
        _setMyWishlistCourse(refreshedCourses);
      });
      _setMyWishlistCourse(wishlistCourses);
      setState(ViewState.idle);
    } on RepositoryException {
      setState(ViewState.error);
    }
  }

  Future<bool> removeFromWishlist(int courseId) async {
    setState(ViewState.busy);
    try {
      await _courseRepository.removeCourseFromWishlist(courseId);
      setState(ViewState.idle);
      return true;
    } on RepositoryException {
      return false;
    }
  }
}
