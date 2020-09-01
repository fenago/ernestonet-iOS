import 'package:flutter/foundation.dart';

import '../exceptions/repository_exception.dart';
import '../models/course/course.dart';
import '../repositories/course/course_repository.dart';
import '../services/payment/payment_service.dart';
import '../utils/alert_dialog_helper.dart' as alert_helper;
import 'base_view_model.dart';

class PaymentExistingCardViewModel extends BaseViewModel {
  final PaymentService _paymentService;
  final CourseRepository _courseRepository;

  PaymentExistingCardViewModel({
    @required PaymentService paymentService,
    @required CourseRepository courseRepository,
  })  : _paymentService = paymentService,
        _courseRepository = courseRepository;

  Future<bool> payWithRazorpay(List<Course> courses, Map<String, dynamic> checkoutOptions) async {
    setState(ViewState.busy);
    try {
      final paymentResponse = await _paymentService.initRazorPay(checkoutOptions);
      setState(ViewState.idle);
      if (paymentResponse.errorMessage != '' || paymentResponse.errorMessage != null) {
        alert_helper.showErrorAlert(paymentResponse.errorMessage);
        return false;
      }
      print('*************** Payment Completed : TransactionID ${paymentResponse.errorMessage}');
      final isSuccess = buyPaidCourse(courses, paymentResponse.errorMessage);
      return isSuccess;
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
      return null;
    }
  }

  Future<bool> buyPaidCourse(List<Course> courses, String transactionId) async {
    setState(ViewState.busy);
    try {
      final isSuccess = await _courseRepository.buyCourse(courses, transactionId);
      setState(ViewState.idle);
      return isSuccess;
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }

  Future<void> removeFromWishlist(int courseId) async {
    try {
      await _courseRepository.removeCourseFromWishlist(courseId);
    } on RepositoryException {
      setState(ViewState.error);
    }
  }

  Future<bool> removeFromCart(Course course) async {
    try {
      final isSuccess = await _courseRepository.removeCourseFromCart(course.id);
      return isSuccess;
    } on RepositoryException {
      setState(ViewState.error);
      return false;
    }
  }
}
