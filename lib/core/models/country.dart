import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Country {
  final int id;
  final int numcode;
  final int phonecode;
  final String iso;
  final String name;
  final String nicename;
  final String iso3;

  Country({
    @required this.id,
    @required this.iso,
    @required this.name,
    @required this.nicename,
    @required this.iso3,
    @required this.numcode,
    @required this.phonecode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
