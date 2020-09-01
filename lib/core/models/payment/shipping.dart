import 'package:edustar/core/models/payment/address.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Shipping {
  final String name;
  final Address address;

  Shipping({
    @required this.name,
    @required this.address,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingToJson(this);
}
