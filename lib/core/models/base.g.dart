// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Base _$BaseFromJson(Map<String, dynamic> json) {
  return Base(
    json['user_status'] as bool,
    json['mobile_verification_status'] as bool,
    json['success'] as bool,
    json['message'] as String,
    json['content'] as String,
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    json['category_banner'] == null
        ? null
        : CategoryBanner.fromJson(
            json['category_banner'] as Map<String, dynamic>),
    (json['course_categories'] as List)
        ?.map((e) => e == null
            ? null
            : CourseCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['announcements'] as List)
        ?.map((e) =>
            e == null ? null : Announcement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['question_answer'] == null
        ? null
        : QuestionAnswer.fromJson(
            json['question_answer'] as Map<String, dynamic>),
    json['user_detail'] == null
        ? null
        : User.fromJson(json['user_detail'] as Map<String, dynamic>),
    json['landing_page'] == null
        ? null
        : Landing.fromJson(json['landing_page'] as Map<String, dynamic>),
    (json['course'] as List)
        ?.map((e) =>
            e == null ? null : Course.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['courses'] as List)
        ?.map((e) =>
            e == null ? null : SearchCourse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['course_detail'] == null
        ? null
        : Course.fromJson(json['course_detail'] as Map<String, dynamic>),
    (json['question_answers'] as List)
        ?.map((e) => e == null
            ? null
            : QuestionAnswer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['cart_details'] as List)
        ?.map((e) =>
            e == null ? null : Course.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['payment_gateway'] as List)
        ?.map((e) => e == null
            ? null
            : PaymentGateway.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BaseToJson(Base instance) => <String, dynamic>{
      'user_status': instance.userStatus,
      'mobile_verification_status': instance.mobileVerificationStatus,
      'success': instance.success,
      'message': instance.message,
      'content': instance.content,
      'author': instance.author?.toJson(),
      'question_answer': instance.questionAnswer?.toJson(),
      'category_banner': instance.categoryBanner?.toJson(),
      'course_categories':
          instance.courseCategories?.map((e) => e?.toJson())?.toList(),
      'announcements':
          instance.announcements?.map((e) => e?.toJson())?.toList(),
      'question_answers':
          instance.questionAnswers?.map((e) => e?.toJson())?.toList(),
      'user_detail': instance.user?.toJson(),
      'landing_page': instance.landingPage?.toJson(),
      'course': instance.myCourses?.map((e) => e?.toJson())?.toList(),
      'courses': instance.searchCourse?.map((e) => e?.toJson())?.toList(),
      'course_detail': instance.courseDetail?.toJson(),
      'cart_details': instance.cartCourses?.map((e) => e?.toJson())?.toList(),
      'payment_gateway':
          instance.paymentGateway?.map((e) => e?.toJson())?.toList(),
    };
