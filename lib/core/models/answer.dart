import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Answer {
  final int id;
  final int courseId;
  final int questionId;

  @JsonKey(name: 'ans_user_id')
  final int answerUserId;

  @JsonKey(name: 'ques_user_id')
  final int questionUserId;

  final int instructorId;
  final bool currentUser;
  final String answer;
  final String createdAt;

  Answer({
    @required this.id,
    @required this.courseId,
    @required this.questionUserId,
    @required this.answerUserId,
    @required this.questionId,
    @required this.instructorId,
    @required this.currentUser,
    @required this.answer,
    @required this.createdAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
