// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Onboard _$OnboardFromJson(Map<String, dynamic> json) {
  return Onboard(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$OnboardToJson(Onboard instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
