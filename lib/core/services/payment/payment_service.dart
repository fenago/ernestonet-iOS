import 'package:edustar/core/constants/api_routes.dart';
import 'package:edustar/core/models/payment/payment_gateway.dart';
import 'package:edustar/core/services/http/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../utils/network_helper.dart' as network_helper;

import '../../../locator.dart';

class PaymentResponse {
  final String paymentId;
  final String errorMessage;

  PaymentResponse({
    @required this.paymentId,
    @required this.errorMessage,
  });
}

class PaymentService {
  final Razorpay _razorpay;
  final ApiService apiService = locator<ApiService>();

  PaymentService({
    @required Razorpay razorpay,
  }) : _razorpay = razorpay;

  Future<PaymentResponse> initRazorPay(Map<String, dynamic> checkoutOptions) async {
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
    Future.doWhile(() => paymentResponse == null);
    print('response : data ');
    return paymentResponse;
  }

  Future<List<PaymentGateway>> getAllPayments() async {
    final response = await apiService.getHttp(ApiRoutes.paymentGateway);
    final paymentGateway = network_helper.decodeResponseBodyToBase(response).paymentGateway;
    return paymentGateway;
  }
}
