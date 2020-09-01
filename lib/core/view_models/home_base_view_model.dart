// import 'package:edustar/core/models/course/course.dart';
// import 'package:flutter/foundation.dart';

// import '../../core/exceptions/network_exception.dart';
// import '../../core/exceptions/repository_exception.dart';
// import '../../core/models/course_category.dart';
// import '../../core/repositories/course/course_repository.dart';
// import '../../core/view_models/base_view_model.dart';
// import '../models/main_category.dart';

// class HomeViewModel extends BaseViewModel {
//   CourseRepository _courseRepository;
//   List<MainCategory> _mainCategories;
//   List<CourseCategory> _courseCategories;

//   List<MainCategory> get mainCategories => _mainCategories;
//   List<CourseCategory> get courseCategories => _courseCategories;

//   HomeViewModel({@required CourseRepository courseRepository}) : _courseRepository = courseRepository;

//   void _setMainCategories(List<MainCategory> mainCategories) {
//     mainCategories = mainCategories;
//     notifyListeners();
//   }

//   void _setCategoryCourses(List<CourseCategory> categoryCourses) {
//     _courseCategories = categoryCourses;
//     notifyListeners();
//   }

//   Future<void> getMainCategories() async {
//     setState(ViewState.busy);
//     try {
//       final mainCategories = await _courseRepository.getAllCategories();
//       _setMainCategories(mainCategories);
//     } on RepositoryException catch (e) {
//       setState(ViewState.error);
//       print(e.message);
//     } finally {
//       setState(ViewState.idle);
//     }
//   }

//   Future<void> getAllCourses() async {
//     setState(ViewState.busy);
//     try {
//       final categoryCourses = await _courseRepository.getAllCategoriesWithCourses();
//       _setCategoryCourses(categoryCourses);
//     } on RepositoryException catch (e) {
//       setState(ViewState.error);
//       print(e.message);
//     } finally {
//       setState(ViewState.idle);
//     }
//   }

//   Future<List<Course>> getCartCourses() async {
//     try {
//       final cartCourses = await _courseRepository.getCartCourses();
//       return cartCourses;
//     } on NetworkException catch (e) {
//       print('Error : ${e.message}');
//       return [];
//     }
//   }
// }
