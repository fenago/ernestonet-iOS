import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/course/course.dart';

part 'course_category.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class CourseCategory {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<Course> courses;

  CourseCategory(this.id, this.title, this.courses);

  factory CourseCategory.fromJson(Map<String, dynamic> json) => _$CourseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryToJson(this);
}
