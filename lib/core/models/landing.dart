import 'package:edustar/core/models/answer.dart';
import 'package:edustar/core/models/author.dart';
import 'package:edustar/core/models/social.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'country.dart';
import 'onboard.dart';

part 'landing.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Landing {
  final Social social;
  final List<Onboard> onboard;
  final List<Country> country;

  Landing({
    @required this.social,
    @required this.onboard,
    @required this.country,
  });

  factory Landing.fromJson(Map<String, dynamic> json) => _$LandingFromJson(json);

  Map<String, dynamic> toJson() => _$LandingToJson(this);
}
