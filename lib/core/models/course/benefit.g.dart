// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BenefitAdapter extends TypeAdapter<Benefit> {
  @override
  final int typeId = 16;

  @override
  Benefit read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Benefit(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Benefit obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.detail);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Benefit _$BenefitFromJson(Map<String, dynamic> json) {
  return Benefit(
    json['id'] as int,
    json['detail'] as String,
  );
}

Map<String, dynamic> _$BenefitToJson(Benefit instance) => <String, dynamic>{
      'id': instance.id,
      'detail': instance.detail,
    };
