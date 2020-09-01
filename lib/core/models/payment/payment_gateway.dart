import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_gateway.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class PaymentGateway {
  final String title;
  final String apiKey;
  final String secretKey;
  final bool active;

  PaymentGateway({
    @required this.title,
    @required this.apiKey,
    @required this.secretKey,
    @required this.active,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => _$PaymentGatewayFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentGatewayToJson(this);
}
