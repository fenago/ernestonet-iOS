import 'package:edustar/core/models/main_category.dart';
import 'package:edustar/core/models/slider.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_banner.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class CategoryBanner {
  @HiveField(0)
  final List<MainCategory> categories;

  @HiveField(42)
  final List<Slider> sliders;

  CategoryBanner(
    this.categories,
    this.sliders,
  );

  factory CategoryBanner.fromJson(Map<String, dynamic> json) => _$CategoryBannerFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBannerToJson(this);
}
