// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileSignIn _$MobileSignInFromJson(Map<String, dynamic> json) {
  return MobileSignIn(
    mobile: json['mobile'] as String,
    password: json['password'] as String,
    role: json['role'] as String,
    device: json['device'] as String,
    mobileToken: json['mobile_token'] as String,
    countryId: json['country_id'] as String,
  );
}

Map<String, dynamic> _$MobileSignInToJson(MobileSignIn instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'password': instance.password,
      'role': instance.role,
      'device': instance.device,
      'mobile_token': instance.mobileToken,
      'country_id': instance.countryId,
    };
