// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurriculumAdapter extends TypeAdapter<Curriculum> {
  @override
  final int typeId = 17;

  @override
  Curriculum read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Curriculum(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      (fields[4] as List)?.cast<Topic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Curriculum obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.courseId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.topics);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Curriculum _$CurriculumFromJson(Map<String, dynamic> json) {
  return Curriculum(
    json['id'] as int,
    json['course_id'] as String,
    json['status'] as String,
    json['chapter_name'] as String,
    (json['courseclass'] as List)?.map((e) => e == null ? null : Topic.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$CurriculumToJson(Curriculum instance) => <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'status': instance.status,
      'chapter_name': instance.title,
      'courseclass': instance.topics?.map((e) => e?.toJson())?.toList(),
    };
