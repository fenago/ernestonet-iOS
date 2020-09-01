// import 'package:edustar/core/models/course/course.dart';
// import 'package:flutter/foundation.dart';

// import '../../core/exceptions/network_exception.dart';
// import '../../core/exceptions/repository_exception.dart';
// import '../../core/models/course_category.dart';
// import '../../core/repositories/course/course_repository.dart';
// import '../../core/view_models/base_view_model.dart';
// import '../models/main_category.dart';

// class HomeCourseCategory {
//   final List<MainCategory> categories;
//   final List<CourseCategory> courseCategories;

//   HomeCourseCategory(this.categories, this.courseCategories);
// }

// class HomeViewModel extends BaseViewModel {
//   CourseRepository _courseRepository;
//   HomeCourseCategory _homeCourseCategory;

//   HomeCourseCategory get homeCourseCategory => _homeCourseCategory;

//   HomeViewModel({@required CourseRepository courseRepository}) : _courseRepository = courseRepository;

//   void refreshHome() {
//     notifyListeners();
//   }

//   void setHomeCourseCategoires(HomeCourseCategory homeCourseCategory) {
//     _homeCourseCategory = homeCourseCategory;
//     notifyListeners();
//   }

//   Future<void> getFullCorurseCategories() async {
//     setState(ViewState.busy);
//     try {
//       final homeCourseCategories = await Future.wait(
//         [
//           _courseRepository.getAllCategories(),
//           _courseRepository.getAllCategoriesWithCourses(),
//         ],
//       );
//       setHomeCourseCategoires(HomeCourseCategory(homeCourseCategories[0], homeCourseCategories[1]));
//       setState(ViewState.idle);
//     } on RepositoryException catch (e) {
//       setState(ViewState.error);
//       print(e.message);
//     }
//   }

//   Future<List<Course>> getCartCourses() async {
//     try {
//       final cartCourses = await _courseRepository.getCartCourses();
//       return cartCourses;
//     } on NetworkException catch (e) {
//       print('Error : ${e.message}');
//       return null;
//     }
//   }
// }

import 'package:edustar/core/models/category_banner.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:flutter/foundation.dart';

import '../../core/exceptions/network_exception.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/models/course_category.dart';
import '../../core/repositories/course/course_repository.dart';
import '../../core/view_models/base_view_model.dart';
import '../models/main_category.dart';

class HomeViewModel extends BaseViewModel {
  CourseRepository _courseRepository;
  CategoryBanner _categoryBanner;
  List<CourseCategory> _courseCategories;

  CategoryBanner get categoryBanner => _categoryBanner;
  List<CourseCategory> get courseCategories => _courseCategories;

  HomeViewModel({@required CourseRepository courseRepository}) : _courseRepository = courseRepository;

  void _setCategoryBanner(CategoryBanner categoryBanner) {
    _categoryBanner = categoryBanner;
    notifyListeners();
  }

  void _setCategoryCourses(List<CourseCategory> categoryCourses) {
    _courseCategories = categoryCourses;
    notifyListeners();
  }

  Future<void> getCategoryBanner() async {
    setState(ViewState.busy);
    try {
      final categoryBanner = await _courseRepository.getCategoryBanner((refreshedCategoryBannery) {
        _setCategoryBanner(refreshedCategoryBannery);
      });
      _setCategoryBanner(categoryBanner);
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      print(e.message);
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<void> getAllCourses() async {
    setState(ViewState.busy);
    try {
      final categoryCourses = await _courseRepository.getAllCategoriesWithCourses((refreshedCourses) {
        _setCategoryCourses(refreshedCourses);
      });
      _setCategoryCourses(categoryCourses);
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      print(e.message);
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<List<Course>> getCartCourses() async {
    try {
      final cartCourses = await _courseRepository.getCartCourses();
      return cartCourses;
    } on NetworkException catch (e) {
      print('Error : ${e.message}');
      return [];
    }
  }
}
