import 'package:flutter/foundation.dart';

class StripeTransactionResponse {
  bool success;
  String message;
  StripeTransactionResponse({@required this.success, @required this.message});
}
