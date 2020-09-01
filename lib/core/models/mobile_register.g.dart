// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileRegister _$MobileRegisterFromJson(Map<String, dynamic> json) {
  return MobileRegister(
    firstName: json['fname'] as String ?? '',
    lastName: json['lname'] as String ?? '',
    email: json['email'] as String,
    mobile: json['mobile'] as String,
    device: json['device'] as String,
    mobileToken: json['mobile_token'] as String,
    password: json['password'] as String,
    countryId: json['country_id'] as String,
  );
}

Map<String, dynamic> _$MobileRegisterToJson(MobileRegister instance) =>
    <String, dynamic>{
      'fname': instance.firstName,
      'lname': instance.lastName,
      'email': instance.email,
      'mobile': instance.mobile,
      'device': instance.device,
      'mobile_token': instance.mobileToken,
      'password': instance.password,
      'country_id': instance.countryId,
    };
