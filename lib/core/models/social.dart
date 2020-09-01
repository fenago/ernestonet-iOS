import 'package:edustar/core/models/answer.dart';
import 'package:edustar/core/models/author.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'social.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Social {
  final bool facebook;
  final bool google;

  Social({
    @required this.facebook,
    @required this.google,
  });

  factory Social.fromJson(Map<String, dynamic> json) => _$SocialFromJson(json);

  Map<String, dynamic> toJson() => _$SocialToJson(this);
}
