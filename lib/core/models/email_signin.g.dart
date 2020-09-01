// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailSignIn _$EmailSignInFromJson(Map<String, dynamic> json) {
  return EmailSignIn(
    email: json['email'] as String,
    from: json['from'] as String,
    name: json['name'] as String,
    device: json['device'] as String,
    mobileToken: json['mobile_token'] as String,
  );
}

Map<String, dynamic> _$EmailSignInToJson(EmailSignIn instance) =>
    <String, dynamic>{
      'email': instance.email,
      'from': instance.from,
      'name': instance.name,
      'device': instance.device,
      'mobile_token': instance.mobileToken,
    };
