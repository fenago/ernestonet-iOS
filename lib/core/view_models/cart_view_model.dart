import 'package:flutter/foundation.dart';

import '../../locator.dart';
import '../exceptions/repository_exception.dart';
import '../models/course/course.dart';
import '../repositories/course/course_repository.dart';
import '../services/local_storage_service.dart';
import '../utils/alert_dialog_helper.dart' as alert_helper;
import 'base_view_model.dart';

class CartViewModel extends BaseViewModel {
  final localStorageService = locator<LocalStorageService>();

  CourseRepository _courseRepository;
  List<Course> _cartCourses = [];

  List<Course> get cartCourses => _cartCourses;

  CartViewModel({@required courseRepository}) : _courseRepository = courseRepository;

  // Cart
  void setCartCourses(List<Course> cartCourses) {
    _cartCourses = cartCourses;
    notifyListeners();
  }

  Future<void> getCartCourses() async {
    setState(ViewState.busy);
    try {
      final cartCourses = await _courseRepository.getCartCourses();
      setCartCourses(cartCourses);
      setState(ViewState.idle);
    } on RepositoryException {
      setState(ViewState.error);
    }
  }

  Future<bool> removeCartCourse(Course course, Course courseDetailCourse) async {
    setState(ViewState.busy);
    try {
      final isRemoved = await _courseRepository.removeCourseFromCart(course.cartId);
      if (isRemoved) {
        final cartCourses = await _courseRepository.getCartCourses();
        setCartCourses(cartCourses);
      }
      setState(ViewState.idle);
      return true;
    } on RepositoryException {
      setState(ViewState.error);
      return false;
    }
  }

  // Course Buying
  // Future<bool> buyCourse(Course course) async {
  //   setState(ViewState.busy);
  //   try {
  //     await _courseRepository.buyCourse(course);
  //     setState(ViewState.idle);
  //     return true;
  //   } on RepositoryException catch (e) {
  //     setState(ViewState.error);
  //     alert_helper.showErrorAlert(e.message);
  //     return false;
  //   }
  // }

  // Future<bool> buyPaidCourse(Course course, String transactionId) async {
  //   setState(ViewState.busy);
  //   try {
  //     await _courseRepository.buyPaidCourse(course, transactionId);
  //     setState(ViewState.idle);
  //     return true;
  //   } on RepositoryException catch (e) {
  //     setState(ViewState.error);
  //     alert_helper.showErrorAlert(e.message);
  //     return false;
  //   }
  // }

  // Future<bool> buyAllCourses(List<Course> courses, List<String> transactionIds) async {
  //   setState(ViewState.busy);
  //   try {
  //     // await _courseRepository.buyAllCourses(coursesId, transactionIds);
  //     setState(ViewState.idle);
  //     return true;
  //   } on RepositoryException catch (e) {
  //     setState(ViewState.error);
  //     alert_helper.showErrorAlert(e.message);
  //     return false;
  //   }
  // }
}
