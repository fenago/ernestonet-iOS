import 'package:edustar/core/models/course/topic.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'curriculum.g.dart';

@HiveType(typeId: 17)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Curriculum {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String courseId;

  @HiveField(2)
  final String status;

  @HiveField(3)
  @JsonKey(name: 'chapter_name')
  final String title;

  @HiveField(4)
  @JsonKey(name: 'courseclass')
  final List<Topic> topics;

  Curriculum(
    this.id,
    this.courseId,
    this.status,
    this.title,
    this.topics,
  );

  factory Curriculum.fromJson(Map<String, dynamic> json) => _$CurriculumFromJson(json);

  Map<String, dynamic> toJson() => _$CurriculumToJson(this);
}
