// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SliderAdapter extends TypeAdapter<Slider> {
  @override
  final int typeId = 42;

  @override
  Slider read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Slider(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Slider obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.image);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slider _$SliderFromJson(Map<String, dynamic> json) {
  return Slider(
    json['image'] as String,
  );
}

Map<String, dynamic> _$SliderToJson(Slider instance) => <String, dynamic>{
      'image': instance.image,
    };
