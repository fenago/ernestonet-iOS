// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionRequest _$QuestionRequestFromJson(Map<String, dynamic> json) {
  return QuestionRequest(
    questionId: json['question_id'] as int,
    id: json['id'] as int,
    topicId: json['topic_id'] as int,
    courseId: json['course_id'] as int,
    answerId: json['answer_id'] as int,
    userId: json['user_id'] as int,
    ansUserId: json['ans_user_id'] as int,
    instructorId: json['instructor_id'] as String,
    question: json['question'] as String,
    answer: json['answer'] as String,
  );
}

Map<String, dynamic> _$QuestionRequestToJson(QuestionRequest instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'id': instance.id,
      'topic_id': instance.topicId,
      'course_id': instance.courseId,
      'answer_id': instance.answerId,
      'user_id': instance.userId,
      'ans_user_id': instance.ansUserId,
      'instructor_id': instance.instructorId,
      'question': instance.question,
      'answer': instance.answer,
    };
