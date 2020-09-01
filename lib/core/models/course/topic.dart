import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@HiveType(typeId: 91)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Topic {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String video;

  @HiveField(2)
  final String previewType;

  @HiveField(3)
  final String duration;

  @HiveField(4)
  final int id;

  @JsonKey(defaultValue: false)
  @HiveField(5)
  bool currentlyPlaying;

  Topic(
    this.title,
    this.video,
    this.previewType,
    this.duration,
    this.id,
    this.currentlyPlaying,
  );

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
