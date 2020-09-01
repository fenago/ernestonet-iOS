// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    id: json['id'] as int,
    iso: json['iso'] as String,
    name: json['name'] as String,
    nicename: json['nicename'] as String,
    iso3: json['iso3'] as String,
    numcode: json['numcode'] as int,
    phonecode: json['phonecode'] as int,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'numcode': instance.numcode,
      'phonecode': instance.phonecode,
      'iso': instance.iso,
      'name': instance.name,
      'nicename': instance.nicename,
      'iso3': instance.iso3,
    };
