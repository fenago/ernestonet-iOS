// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGateway _$PaymentGatewayFromJson(Map<String, dynamic> json) {
  return PaymentGateway(
    title: json['title'] as String,
    apiKey: json['api_key'] as String,
    secretKey: json['secret_key'] as String,
    active: json['active'] as bool,
  );
}

Map<String, dynamic> _$PaymentGatewayToJson(PaymentGateway instance) =>
    <String, dynamic>{
      'title': instance.title,
      'api_key': instance.apiKey,
      'secret_key': instance.secretKey,
      'active': instance.active,
    };
