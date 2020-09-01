// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorAdapter extends TypeAdapter<Author> {
  @override
  final int typeId = 19;

  @override
  Author read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Author(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as String,
      fields[6] as int,
      (fields[7] as List)?.cast<Course>(),
    );
  }

  @override
  void write(BinaryWriter writer, Author obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.aboutBio)
      ..writeByte(2)
      ..write(obj.avatar)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.noOfCourses)
      ..writeByte(5)
      ..write(obj.noOfReviews)
      ..writeByte(6)
      ..write(obj.noOfStudents)
      ..writeByte(7)
      ..write(obj.courses);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    json['name'] as String,
    json['about_bio'] as String,
    json['avatar'] as String,
    json['role'] as String ?? 'role',
    json['no_of_courses_count'] as int,
    json['reviews_count'] as String,
    json['no_of_students'] as int,
    (json['courses'] as List)?.map((e) => e == null ? null : Course.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
      'about_bio': instance.aboutBio,
      'avatar': instance.avatar,
      'role': instance.role,
      'no_of_courses_count': instance.noOfCourses,
      'reviews_count': instance.noOfReviews,
      'no_of_students': instance.noOfStudents,
      'courses': instance.courses?.map((e) => e?.toJson())?.toList(),
    };
