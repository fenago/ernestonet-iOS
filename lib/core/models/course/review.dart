import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@HiveType(typeId: 18)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Review {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  @JsonKey(name: 'value')
  final int ratings;

  @HiveField(3)
  final String review;

  @HiveField(4)
  final String reviewerName;

  @HiveField(5)
  final String createdAt;

  Review(
    this.id,
    this.userId,
    this.ratings,
    this.review,
    this.reviewerName,
    this.createdAt,
  );

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
