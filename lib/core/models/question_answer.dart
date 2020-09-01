import 'package:edustar/core/models/answer.dart';
import 'package:edustar/core/models/author.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_answer.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class QuestionAnswer {
  final int id;
  final int instructorId;
  final int userId;
  final int courseId;
  final String question;
  final String createdAt;
  final bool currentUser;
  final Author author;

  @JsonKey(name: 'answer')
  final List<Answer> answers;

  QuestionAnswer({
    @required this.id,
    @required this.instructorId,
    @required this.userId,
    @required this.courseId,
    @required this.question,
    @required this.createdAt,
    @required this.author,
    @required this.currentUser,
    @required this.answers,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => _$QuestionAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionAnswerToJson(this);
}
