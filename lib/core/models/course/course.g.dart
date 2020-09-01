// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 4;

  @override
  Course read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as double,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
      fields[11] as String,
      fields[12] as String,
      fields[13] as String,
      fields[14] as String,
      (fields[15] as List)?.cast<CourseInclude>(),
      (fields[16] as List)?.cast<Benefit>(),
      (fields[17] as List)?.cast<Curriculum>(),
      (fields[18] as List)?.cast<Review>(),
      fields[19] as Author,
      fields[20] as bool,
      fields[21] as bool,
      fields[22] as bool,
      fields[23] as String,
      fields[24] as String,
      fields[25] as String,
      fields[26] as Currency,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.cartId)
      ..writeByte(3)
      ..write(obj.avgRating)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.detail)
      ..writeByte(8)
      ..write(obj.shortDetail)
      ..writeByte(9)
      ..write(obj.requirement)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.discountPrice)
      ..writeByte(12)
      ..write(obj.video)
      ..writeByte(13)
      ..write(obj.image)
      ..writeByte(14)
      ..write(obj.previewType)
      ..writeByte(15)
      ..write(obj.courseIncludes)
      ..writeByte(16)
      ..write(obj.benefits)
      ..writeByte(17)
      ..write(obj.curriculum)
      ..writeByte(18)
      ..write(obj.reviews)
      ..writeByte(19)
      ..write(obj.author)
      ..writeByte(20)
      ..write(obj.wishlist)
      ..writeByte(21)
      ..write(obj.cart)
      ..writeByte(22)
      ..write(obj.enrolled)
      ..writeByte(23)
      ..write(obj.categoryId)
      ..writeByte(24)
      ..write(obj.type)
      ..writeByte(25)
      ..write(obj.courseUrl)
      ..writeByte(26)
      ..write(obj.currency);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    json['id'] as int,
    json['order_id'] as int,
    json['cart_id'] as int,
    (json['avg_rating'] as num)?.toDouble(),
    json['user_id'] as String,
    json['status'] as String,
    json['title'] as String,
    json['detail'] as String,
    json['short_detail'] as String,
    json['requirement'] as String,
    json['price'] as String,
    json['discount_price'] as String,
    json['sample_video'] as String,
    json['preview_image'] as String,
    json['preview_type'] as String,
    (json['courseinclude'] as List)?.map((e) => e == null ? null : CourseInclude.fromJson(e as Map<String, dynamic>))?.toList() ?? [],
    (json['benefits'] as List)?.map((e) => e == null ? null : Benefit.fromJson(e as Map<String, dynamic>))?.toList(),
    (json['coursechapters'] as List)?.map((e) => e == null ? null : Curriculum.fromJson(e as Map<String, dynamic>))?.toList(),
    (json['reviews'] as List)?.map((e) => e == null ? null : Review.fromJson(e as Map<String, dynamic>))?.toList(),
    json['author'] == null ? null : Author.fromJson(json['author'] as Map<String, dynamic>),
    json['wishlist'] as bool ?? false,
    json['cart'] as bool ?? false,
    json['enrolled'] as bool ?? false,
    json['category_id'] as String,
    json['type'] as String,
    json['course_url'] as String,
    json['currency'] == null ? null : Currency.fromJson(json['currency'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'cart_id': instance.cartId,
      'avg_rating': instance.avgRating,
      'user_id': instance.userId,
      'status': instance.status,
      'title': instance.title,
      'detail': instance.detail,
      'short_detail': instance.shortDetail,
      'requirement': instance.requirement,
      'price': instance.price,
      'discount_price': instance.discountPrice,
      'sample_video': instance.video,
      'preview_image': instance.image,
      'preview_type': instance.previewType,
      'courseinclude': instance.courseIncludes?.map((e) => e?.toJson())?.toList(),
      'benefits': instance.benefits?.map((e) => e?.toJson())?.toList(),
      'coursechapters': instance.curriculum?.map((e) => e?.toJson())?.toList(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
      'author': instance.author?.toJson(),
      'wishlist': instance.wishlist,
      'cart': instance.cart,
      'enrolled': instance.enrolled,
      'category_id': instance.categoryId,
      'type': instance.type,
      'course_url': instance.courseUrl,
      'currency': instance.currency?.toJson(),
    };
