import 'package:edustar/core/models/course/currency.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../author.dart';
import 'benefit.dart';
import 'course_include.dart';
import 'curriculum.dart';
import 'review.dart';

part 'course.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Course {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int orderId;

  @HiveField(2)
  int cartId;

  @HiveField(3)
  final double avgRating;

  @HiveField(4)
  final String userId;

  @HiveField(5)
  final String status;

  @HiveField(6)
  final String title;

  @HiveField(7)
  final String detail;

  @HiveField(8)
  final String shortDetail;

  @HiveField(9)
  final String requirement;

  @HiveField(10)
  final String price;

  @HiveField(11)
  final String discountPrice;

  @HiveField(12)
  @JsonKey(name: 'sample_video')
  final String video;

  @HiveField(13)
  @JsonKey(name: 'preview_image')
  final String image;

  @HiveField(14)
  final String previewType;

  @HiveField(15)
  @JsonKey(name: 'courseinclude', defaultValue: [])
  final List<CourseInclude> courseIncludes;

  @HiveField(16)
  final List<Benefit> benefits;

  @HiveField(17)
  @JsonKey(name: 'coursechapters')
  final List<Curriculum> curriculum;

  @HiveField(18)
  final List<Review> reviews;

  @HiveField(19)
  final Author author;

  @HiveField(20)
  @JsonKey(defaultValue: false)
  bool wishlist;

  @HiveField(21)
  @JsonKey(defaultValue: false)
  bool cart;

  @HiveField(22)
  @JsonKey(defaultValue: false)
  bool enrolled;

  @HiveField(23)
  final String categoryId;

  @HiveField(24)
  final String type;

  @HiveField(25)
  final String courseUrl;

  @HiveField(26)
  final Currency currency;

  Course(
    this.id,
    this.orderId,
    this.cartId,
    this.avgRating,
    this.userId,
    this.status,
    this.title,
    this.detail,
    this.shortDetail,
    this.requirement,
    this.price,
    this.discountPrice,
    this.video,
    this.image,
    this.previewType,
    this.courseIncludes,
    this.benefits,
    this.curriculum,
    this.reviews,
    this.author,
    this.wishlist,
    this.cart,
    this.enrolled,
    this.categoryId,
    this.type,
    this.courseUrl,
    this.currency,
  );

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
