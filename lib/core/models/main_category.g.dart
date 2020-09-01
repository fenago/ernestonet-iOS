// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainCategoryAdapter extends TypeAdapter<MainCategory> {
  @override
  final int typeId = 1;

  @override
  MainCategory read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainCategory(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MainCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.icon);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCategory _$MainCategoryFromJson(Map<String, dynamic> json) {
  return MainCategory(
    json['id'] as int,
    json['title'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$MainCategoryToJson(MainCategory instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
    };
