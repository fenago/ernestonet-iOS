import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stripe_payment_intent.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class StripePaymentIntent {
  final String amount, currency;
  final String description;
  final List<String> paymentMethodTypes;

  StripePaymentIntent({
    @required this.amount,
    this.currency,
    @required this.description,
    @required this.paymentMethodTypes,
  });

  factory StripePaymentIntent.fromJson(Map<String, dynamic> json) => _$StripePaymentIntentFromJson(json);

  Map<String, dynamic> toJson() => _$StripePaymentIntentToJson(this);
}
