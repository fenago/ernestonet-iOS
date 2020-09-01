import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_category.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class MainCategory {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String icon;

  MainCategory(this.id, this.title, this.icon);

  factory MainCategory.fromJson(Map<String, dynamic> json) => _$MainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoryToJson(this);
}
