import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mobile_register.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MobileRegister {
  @JsonKey(defaultValue: '', name: 'fname')
  final String firstName;

  @JsonKey(defaultValue: '', name: 'lname')
  final String lastName;
  final String email;
  final String mobile;
  final String device;
  final String mobileToken;
  final String password;
  final String countryId;

  MobileRegister({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.mobile,
    @required this.device,
    @required this.mobileToken,
    @required this.password,
    @required this.countryId,
  });

  factory MobileRegister.fromJson(Map<String, dynamic> json) => _$MobileRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$MobileRegisterToJson(this);
}
