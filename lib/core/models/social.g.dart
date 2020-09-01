// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Social _$SocialFromJson(Map<String, dynamic> json) {
  return Social(
    facebook: json['facebook'] as bool,
    google: json['google'] as bool,
  );
}

Map<String, dynamic> _$SocialToJson(Social instance) => <String, dynamic>{
      'facebook': instance.facebook,
      'google': instance.google,
    };
