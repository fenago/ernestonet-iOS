import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_request.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class QuestionRequest {
  int questionId;
  int id;
  int topicId;
  int courseId;
  int answerId;
  int userId;
  int ansUserId;
  String instructorId;
  String question;
  String answer;

  QuestionRequest({
    this.questionId,
    this.id,
    this.topicId,
    this.courseId,
    this.answerId,
    this.userId,
    this.ansUserId,
    this.instructorId,
    this.question,
    this.answer,
  });

  factory QuestionRequest.fromJson(Map<String, dynamic> json) => _$QuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionRequestToJson(this);
}
