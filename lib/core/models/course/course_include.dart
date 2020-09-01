import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_include.g.dart';

@HiveType(typeId: 15)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class CourseInclude {
  @HiveField(0)
  final String status;

  @HiveField(1)
  final String icon;

  @HiveField(2)
  final String detail;

  CourseInclude(
    this.status,
    this.icon,
    this.detail,
  );

  factory CourseInclude.fromJson(Map<String, dynamic> json) => _$CourseIncludeFromJson(json);

  Map<String, dynamic> toJson() => _$CourseIncludeToJson(this);
}
