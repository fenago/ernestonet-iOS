import 'package:json_annotation/json_annotation.dart';

import 'author.dart';

part 'announcement.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Announcement {
  final int id;
  final String userId;
  final String courseId;
  final String createdAt;

  @JsonKey(defaultValue: 'Title')
  final String title;

  @JsonKey(name: 'announsment')
  final String description;
  final Author author;

  Announcement(
    this.id,
    this.userId,
    this.courseId,
    this.createdAt,
    this.title,
    this.description,
    this.author,
  );

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
