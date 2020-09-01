// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_include.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseIncludeAdapter extends TypeAdapter<CourseInclude> {
  @override
  final int typeId = 15;

  @override
  CourseInclude read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseInclude(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourseInclude obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.detail);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInclude _$CourseIncludeFromJson(Map<String, dynamic> json) {
  return CourseInclude(
    json['status'] as String,
    json['icon'] as String,
    json['detail'] as String,
  );
}

Map<String, dynamic> _$CourseIncludeToJson(CourseInclude instance) => <String, dynamic>{
      'status': instance.status,
      'icon': instance.icon,
      'detail': instance.detail,
    };
