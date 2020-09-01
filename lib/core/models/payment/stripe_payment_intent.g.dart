// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_payment_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripePaymentIntent _$StripePaymentIntentFromJson(Map<String, dynamic> json) {
  return StripePaymentIntent(
    amount: json['amount'] as String,
    currency: json['currency'] as String,
    description: json['description'] as String,
    paymentMethodTypes: (json['payment_method_types'] as List)
        ?.map((e) => e as String)
        ?.toList(),
  );
}

Map<String, dynamic> _$StripePaymentIntentToJson(
        StripePaymentIntent instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'payment_method_types': instance.paymentMethodTypes,
    };
