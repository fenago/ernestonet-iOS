// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseCategoryAdapter extends TypeAdapter<CourseCategory> {
  @override
  final int typeId = 2;

  @override
  CourseCategory read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseCategory(
      fields[0] as int,
      fields[1] as String,
      (fields[2] as List)?.cast<Course>(),
    );
  }

  @override
  void write(BinaryWriter writer, CourseCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.courses);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCategory _$CourseCategoryFromJson(Map<String, dynamic> json) {
  return CourseCategory(
    json['id'] as int,
    json['title'] as String,
    (json['courses'] as List)?.map((e) => e == null ? null : Course.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$CourseCategoryToJson(CourseCategory instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'courses': instance.courses?.map((e) => e?.toJson())?.toList(),
    };
