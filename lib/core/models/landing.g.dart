// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Landing _$LandingFromJson(Map<String, dynamic> json) {
  return Landing(
    social: json['social'] == null
        ? null
        : Social.fromJson(json['social'] as Map<String, dynamic>),
    onboard: (json['onboard'] as List)
        ?.map((e) =>
            e == null ? null : Onboard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    country: (json['country'] as List)
        ?.map((e) =>
            e == null ? null : Country.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LandingToJson(Landing instance) => <String, dynamic>{
      'social': instance.social?.toJson(),
      'onboard': instance.onboard?.map((e) => e?.toJson())?.toList(),
      'country': instance.country?.map((e) => e?.toJson())?.toList(),
    };
