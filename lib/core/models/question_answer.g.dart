// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAnswer _$QuestionAnswerFromJson(Map<String, dynamic> json) {
  return QuestionAnswer(
    id: json['id'] as int,
    instructorId: json['instructor_id'] as int,
    userId: json['user_id'] as int,
    courseId: json['course_id'] as int,
    question: json['question'] as String,
    createdAt: json['created_at'] as String,
    author: json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    currentUser: json['current_user'] as bool,
    answers: (json['answer'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionAnswerToJson(QuestionAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'instructor_id': instance.instructorId,
      'user_id': instance.userId,
      'course_id': instance.courseId,
      'question': instance.question,
      'created_at': instance.createdAt,
      'current_user': instance.currentUser,
      'author': instance.author?.toJson(),
      'answer': instance.answers?.map((e) => e?.toJson())?.toList(),
    };
