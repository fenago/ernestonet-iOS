import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../../locator.dart';
import '../exceptions/repository_exception.dart';
import '../models/course/course.dart';
import '../repositories/course/course_repository.dart';
import '../services/local_storage_service.dart';
import 'base_view_model.dart';

class CourseDetailViewModel extends BaseViewModel {
  final localStorageService = locator<LocalStorageService>();
  Course _course;
  CourseRepository _courseRepository;
  File downloadedVideo;
  bool isWishlistLoading = false;
  bool isCartLoading = false;

  Course get course => _course;

  CourseDetailViewModel({
    @required courseRepository,
  }) : _courseRepository = courseRepository;

  void setCourse(Course course) {
    _course = course;
    notifyListeners();
  }

  void updateWishlistButtonProgress(bool status) {
    isWishlistLoading = status;
    notifyListeners();
  }

  void updateCartButtonProgress(bool status) {
    isCartLoading = status;
    notifyListeners();
  }

  void setCourseVideo(File videoFile) {
    downloadedVideo = videoFile;
    notifyListeners();
  }

  Future<bool> enrollFreeCourse(Course ourses) async {
    updateCartButtonProgress(true);
    try {
      final bought = await _courseRepository.enrollFreeCourse(course);
      return bought;
    } on RepositoryException {
      setState(ViewState.error);
      return false;
    } finally {
      updateCartButtonProgress(false);
    }
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

  // Cart
  Future<bool> updateCart(Course course, {bool addToCart}) async {
    print('**** COURSE CART ID : ${course.cartId}');
    updateCartButtonProgress(true);
    try {
      bool isSuccess = false;
      if (addToCart) {
        isSuccess = await _courseRepository.addCourseToCart(course);
      } else {
        isSuccess = await _courseRepository.removeCourseFromCart(course.cartId);
      }
      if (isSuccess) {
        updateCartStatus(addToCart);
      }
      return isSuccess;
    } on RepositoryException catch (e) {
      updateCartButtonProgress(false);
      setState(ViewState.error);
      alert_helper.showAlert(e.message);
      return false;
    }
  }

  void updateCartStatus(bool status) {
    course.cart = status;
    notifyListeners();
  }

  // Wishlist
  Future<bool> updateWishlist(Course course, {bool addToWishlist}) async {
    updateWishlistButtonProgress(true);
    try {
      bool isSuccess = false;
      if (addToWishlist) {
        isSuccess = await _courseRepository.addCourseToWishlist(course);
      } else {
        isSuccess = await _courseRepository.removeCourseFromWishlist(course.id);
      }
      if (isSuccess) {
        updateWishlistStatus(addToWishlist);
      }
      return isSuccess;
    } on RepositoryException catch (e) {
      updateWishlistButtonProgress(false);
      setState(ViewState.error);
      alert_helper.showAlert(e.message);
      return false;
    }
  }

  void updateWishlistStatus(bool status) {
    course.wishlist = status;
    notifyListeners();
  }

  void refreshCourse() {
    updateCartButtonProgress(false);
    updateWishlistButtonProgress(false);
  }
}
