// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    id: json['id'] as int,
    courseId: json['course_id'] as int,
    questionUserId: json['ques_user_id'] as int,
    answerUserId: json['ans_user_id'] as int,
    questionId: json['question_id'] as int,
    instructorId: json['instructor_id'] as int,
    currentUser: json['current_user'] as bool,
    answer: json['answer'] as String,
    createdAt: json['created_at'] as String,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'question_id': instance.questionId,
      'ans_user_id': instance.answerUserId,
      'ques_user_id': instance.questionUserId,
      'instructor_id': instance.instructorId,
      'current_user': instance.currentUser,
      'answer': instance.answer,
      'created_at': instance.createdAt,
    };
