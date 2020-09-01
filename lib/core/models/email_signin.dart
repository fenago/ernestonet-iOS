import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_signin.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class EmailSignIn {
  final String email;
  final String from;
  final String name;
  final String device;
  final String mobileToken;

  EmailSignIn({
    @required this.email,
    @required this.from,
    @required this.name,
    @required this.device,
    @required this.mobileToken,
  });

  factory EmailSignIn.fromJson(Map<String, dynamic> json) => _$EmailSignInFromJson(json);

  Map<String, dynamic> toJson() => _$EmailSignInToJson(this);
}
