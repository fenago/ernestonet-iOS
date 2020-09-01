// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCourse _$SearchCourseFromJson(Map<String, dynamic> json) {
  return SearchCourse(
    json['id'] as int,
    json['enrolled'] as bool,
    json['title'] as String,
    json['discount_price'] as String,
    json['price'] as String,
    json['user_id'] as String,
    json['type'] as String,
    json['image'] as String,
    (json['avg_rating'] as num)?.toDouble(),
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    json['currency'] == null
        ? null
        : Currency.fromJson(json['currency'] as Map<String, dynamic>),
    (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchCourseToJson(SearchCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enrolled': instance.enrolled,
      'title': instance.title,
      'discount_price': instance.discountPrice,
      'price': instance.price,
      'user_id': instance.userId,
      'type': instance.type,
      'image': instance.image,
      'avg_rating': instance.avgRating,
      'author': instance.author?.toJson(),
      'currency': instance.currency?.toJson(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
    };
