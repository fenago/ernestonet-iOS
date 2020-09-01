import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course/course.dart';

part 'author.g.dart';

@HiveType(typeId: 19)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Author {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String aboutBio;

  @HiveField(2)
  final String avatar;

  @HiveField(3)
  @JsonKey(defaultValue: 'role')
  final String role;

  @HiveField(4)
  @JsonKey(name: 'no_of_courses_count')
  final int noOfCourses;

  @HiveField(5)
  @JsonKey(name: 'reviews_count')
  final String noOfReviews;

  @HiveField(6)
  final int noOfStudents;

  @HiveField(7)
  final List<Course> courses;

  Author(
    this.name,
    this.aboutBio,
    this.avatar,
    this.role,
    this.noOfCourses,
    this.noOfReviews,
    this.noOfStudents,
    this.courses,
  );

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
