// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) {
  return Announcement(
    json['id'] as int,
    json['user_id'] as String,
    json['course_id'] as String,
    json['created_at'] as String,
    json['title'] as String ?? 'Title',
    json['announsment'] as String,
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'course_id': instance.courseId,
      'created_at': instance.createdAt,
      'title': instance.title,
      'announsment': instance.description,
      'author': instance.author?.toJson(),
    };
