import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mobile_signin.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MobileSignIn {
  final String mobile;
  final String password;
  final String role;
  final String device;
  final String mobileToken;
  final String countryId;

  MobileSignIn({
    @required this.mobile,
    @required this.password,
    @required this.role,
    @required this.device,
    @required this.mobileToken,
    @required this.countryId,
  });

  factory MobileSignIn.fromJson(Map<String, dynamic> json) => _$MobileSignInFromJson(json);

  Map<String, dynamic> toJson() => _$MobileSignInToJson(this);
}
