import 'package:edustar/core/models/author.dart';
import 'package:edustar/core/models/course/review.dart';
import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'search_course.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class SearchCourse {
  final int id;
  final bool enrolled;
  final String title;
  final String discountPrice;
  final String price;
  final String userId;
  final String type;
  final String image;
  final double avgRating;
  final Author author;
  final Currency currency;
  final List<Review> reviews;

  SearchCourse(
    this.id,
    this.enrolled,
    this.title,
    this.discountPrice,
    this.price,
    this.userId,
    this.type,
    this.image,
    this.avgRating,
    this.author,
    this.currency,
    this.reviews,
  );

  factory SearchCourse.fromJson(Map<String, dynamic> json) => _$SearchCourseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCourseToJson(this);
}
