import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Address {
  final String line1;
  final String postalCode;
  final String city;
  final String state;
  final String country;

  Address({
    @required this.line1,
    @required this.postalCode,
    @required this.city,
    @required this.state,
    @required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
