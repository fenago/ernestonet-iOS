// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopicAdapter extends TypeAdapter<Topic> {
  @override
  final int typeId = 91;

  @override
  Topic read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Topic(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Topic obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.video)
      ..writeByte(2)
      ..write(obj.previewType)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.currentlyPlaying);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
    json['title'] as String,
    json['video'] as String,
    json['preview_type'] as String,
    json['duration'] as String,
    json['id'] as int,
    json['currently_playing'] as bool ?? false,
  );
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'title': instance.title,
      'video': instance.video,
      'preview_type': instance.previewType,
      'duration': instance.duration,
      'id': instance.id,
      'currently_playing': instance.currentlyPlaying,
    };
