import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboard.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Onboard {
  final int id;
  final String name;
  final String description;
  final String image;

  Onboard({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.image,
  });

  factory Onboard.fromJson(Map<String, dynamic> json) => _$OnboardFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardToJson(this);
}
