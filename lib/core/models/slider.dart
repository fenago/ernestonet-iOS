import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slider.g.dart';

@HiveType(typeId: 42)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Slider {
  @HiveField(0)
  final String image;

  Slider(this.image);

  factory Slider.fromJson(Map<String, dynamic> json) => _$SliderFromJson(json);

  Map<String, dynamic> toJson() => _$SliderToJson(this);
}
