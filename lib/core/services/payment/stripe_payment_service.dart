import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

import '../../models/payment/stripe_transaction_response.dart';

class StripePaymentService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripePaymentService.apiBase}/payment_intents';
  static String secret = '';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripePaymentService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  Future<StripeTransactionResponse> payWithNewCard({
    @required Map<String, String> stripeKeyCredentials,
    @required String amount,
    @required String currency,
    @required String courseName,
  }) async {
    try {
      secret = stripeKeyCredentials['secret_key'];
      StripePayment.setOptions(
        StripeOptions(
          publishableKey: stripeKeyCredentials['api_key'],
          merchantId: "Test",
          androidPayMode: 'test',
        ),
      );

      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );
      final paymentIntent = await StripePaymentService.createPaymentIntent(amount, currency, courseName);
      print('PAYMENT INTENT $paymentIntent');
      final confirmPaymentResponse = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (confirmPaymentResponse.status == 'succeeded') {
        return StripeTransactionResponse(
          success: true,
          message: 'Transaction success',
        );
      } else {
        return StripeTransactionResponse(
          success: false,
          message: 'Transaction failed',
        );
      }
    } on PlatformException catch (e) {
      return StripePaymentService.getPlatformExceptionResult(e);
    } catch (e) {
      return StripeTransactionResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  static StripeTransactionResponse getPlatformExceptionResult(PlatformException exception) {
    String message = 'Something went wrong';
    if (exception.code == 'cancelled') {
      message = 'Transaction cancelled';
    }
    return StripeTransactionResponse(
      success: false,
      message: message,
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency, String courseName) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': courseName,
      };

      final response = await http.post(
        StripePaymentService.paymentApiUrl,
        body: body,
        headers: headers,
      );
      print('Response : Payment Intent ${response.body}');
      return jsonDecode(response.body);
    } catch (e) {
      print('Error charging user : ${e.toString()}');
    }
    return null;
  }
}
