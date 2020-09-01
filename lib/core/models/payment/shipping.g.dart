// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shipping _$ShippingFromJson(Map<String, dynamic> json) {
  return Shipping(
    name: json['name'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShippingToJson(Shipping instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address?.toJson(),
    };
