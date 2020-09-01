import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@HiveType(typeId: 25)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Currency {
  @HiveField(0)
  final String currency;

  @HiveField(1)
  final String symbol;

  Currency(
    this.currency,
    this.symbol,
  );

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
