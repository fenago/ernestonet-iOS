import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String mobile;

  @HiveField(2)
  @JsonKey(defaultValue: '')
  final String name;

  @HiveField(3)
  @JsonKey(defaultValue: '')
  final String email;

  @HiveField(4)
  @JsonKey(defaultValue: '')
  final String userImg;

  @HiveField(5)
  @JsonKey(defaultValue: '')
  final String address;

  @HiveField(6)
  @JsonKey(defaultValue: '', name: 'fname')
  final String firstName;

  @HiveField(7)
  @JsonKey(defaultValue: '', name: 'lname')
  final String lastName;

  @HiveField(8)
  @JsonKey(defaultValue: '', name: 'country_code')
  final String countryCode;

  @HiveField(9)
  @JsonKey(defaultValue: 0, name: 'country_id')
  final int countryId;

  @JsonKey(defaultValue: 0, name: 'is_new')
  final int isNew;

  User({
    this.id,
    this.name,
    this.email,
    this.userImg,
    this.mobile,
    this.address,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.countryId,
    this.isNew,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
