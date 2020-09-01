import 'package:edustar/core/models/payment/payment_gateway.dart';
import 'package:edustar/core/models/payment/stripe_transaction_response.dart';
import 'package:edustar/core/services/payment/stripe_payment_service.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../locator.dart';
import '../exceptions/repository_exception.dart';
import '../models/course/course.dart';
import '../repositories/course/course_repository.dart';
import '../services/payment/payment_service.dart';
import '../utils/alert_dialog_helper.dart' as alert_helper;
import 'base_view_model.dart';

class PaymentSelectionViewModel extends BaseViewModel {
  final PaymentService _paymentService;
  final CourseRepository _courseRepository;
  final StripePaymentService _stripePaymentService = locator<StripePaymentService>();

  bool _paymentSuccess = false;
  List<PaymentGateway> _paymentGateways = [];
  bool fetchPaymentLoading = false;

  bool get paymentSuccess => _paymentSuccess;
  List<PaymentGateway> get paymentGateways => _paymentGateways;

  PaymentSelectionViewModel({
    @required PaymentService paymentService,
    @required CourseRepository courseRepository,
  })  : _paymentService = paymentService,
        _courseRepository = courseRepository;

  void updatePaymentStatus(bool value) {
    _paymentSuccess = value;
    notifyListeners();
  }

  void _setPaymentGateways(List<PaymentGateway> paymentGateways) {
    List<PaymentGateway> payments = [];
    for (var payment in paymentGateways) {
      if (payment.active) {
        payments.add(payment);
      }
    }
    _paymentGateways = payments;
    _paymentLoadingState(false);
  }

  void _paymentLoadingState(bool value) {
    fetchPaymentLoading = value;
    notifyListeners();
  }

  Future<void> getPaymentList() async {
    _paymentLoadingState(true);
    try {
      final paymentGateways = await _paymentService.getAllPayments();
      _setPaymentGateways(paymentGateways);
    } on RepositoryException {
      setState(ViewState.error);
    } finally {
      _paymentLoadingState(false);
    }
  }

  Future<void> payWithRazorpay(List<Course> courses, Map<String, dynamic> checkoutOptions, Function(bool) paymentStatus) async {
    setState(ViewState.busy);
    try {
      Razorpay _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) async {
        print('********* 💰🤑 Payment ID ********* : ${response.paymentId}');
        final isSuccess = await buyPaidCourse(courses, response.paymentId);
        setState(ViewState.idle);
        paymentStatus(isSuccess);
      });
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
        final errorMessage = 'ERROR: ' + response.code.toString() + ' - ' + response.message;
        alert_helper.showErrorAlert(errorMessage);
        setState(ViewState.idle);
        paymentStatus(false);
      });
      _razorpay.open(checkoutOptions);
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }

  Future<bool> buyPaidCourse(List<Course> courses, String transactionId) async {
    setState(ViewState.busy);
    try {
      final bought = await _courseRepository.buyCourse(courses, transactionId);
      setState(ViewState.idle);
      return bought;
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }

  // TODO: - OLD Using Payment Service
  Future<bool> payWithRazorpayUsingPaymentService(List<Course> courses, Map<String, dynamic> checkoutOptions) async {
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
      return false;
    }
  }

  Future<PaymentResponse> initRazorPay(Map<String, dynamic> checkoutOptions) async {
    Razorpay _razorpay;
    PaymentResponse paymentResponse;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      print('********* 💰🤑 Payment ID ********* : ${response.paymentId}');
      paymentResponse = PaymentResponse(paymentId: response.paymentId, errorMessage: '');
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      final errorMessage = 'ERROR: ' + response.code.toString() + ' - ' + response.message;
      paymentResponse = PaymentResponse(paymentId: '', errorMessage: errorMessage);
    });
    _razorpay.open(checkoutOptions);
    return paymentResponse;
  }

  // Stripe
  Future<StripeTransactionResponse> payWithCard(Map<String, String> stripeKeyCredentialsData, List<Course> courses) async {
    setState(ViewState.busy);
    try {
      int amount = 0;
      String courseName = '';

      courses.forEach((course) {
        courseName = courseName + ', ' + course.title;
        amount = amount + int.parse(course.price);
      });
      final stripeResponse = await _stripePaymentService.payWithNewCard(
        stripeKeyCredentials: stripeKeyCredentialsData,
        amount: amount.toString(),
        currency: 'USD',
        courseName: courseName,
      );

      return stripeResponse;
    } on RepositoryException catch (e) {
      print('Stripe exception');
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
      return null;
    } finally {
      setState(ViewState.idle);
    }
  }
}
