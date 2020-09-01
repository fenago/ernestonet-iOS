import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'benefit.g.dart';

@HiveType(typeId: 16)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Benefit {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String detail;

  Benefit(
    this.id,
    this.detail,
  );

  factory Benefit.fromJson(Map<String, dynamic> json) => _$BenefitFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitToJson(this);
}
