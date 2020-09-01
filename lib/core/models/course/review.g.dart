// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewAdapter extends TypeAdapter<Review> {
  @override
  final int typeId = 18;

  @override
  Review read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Review(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Review obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.ratings)
      ..writeByte(3)
      ..write(obj.review)
      ..writeByte(4)
      ..write(obj.reviewerName)
      ..writeByte(5)
      ..write(obj.createdAt);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['id'] as int,
    json['user_id'] as String,
    json['value'] as int,
    json['review'] as String,
    json['reviewer_name'] as String,
    json['created_at'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'value': instance.ratings,
      'review': instance.review,
      'reviewer_name': instance.reviewerName,
      'created_at': instance.createdAt,
    };
