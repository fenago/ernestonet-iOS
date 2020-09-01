// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    line1: json['line1'] as String,
    postalCode: json['postal_code'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'line1': instance.line1,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
