import 'package:json_annotation/json_annotation.dart';

import '../../core/models/course_category.dart';
import '../../core/models/user.dart';
import 'announcement.dart';
import 'author.dart';
import 'category_banner.dart';
import 'course/course.dart';
import 'course/search_course.dart';
import 'landing.dart';
import 'payment/payment_gateway.dart';
import 'question_answer.dart';

part 'base.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Base {
  final bool userStatus;
  final bool mobileVerificationStatus;
  final bool success;
  final String message;
  final String content;
  final Author author;
  final QuestionAnswer questionAnswer;
  final CategoryBanner categoryBanner;
  final List<CourseCategory> courseCategories;
  final List<Announcement> announcements;
  final List<QuestionAnswer> questionAnswers;

  @JsonKey(name: 'user_detail')
  final User user;

  final Landing landingPage;

  @JsonKey(name: 'course')
  final List<Course> myCourses;

  @JsonKey(name: 'courses')
  final List<SearchCourse> searchCourse;

  final Course courseDetail;

  @JsonKey(name: 'cart_details')
  List<Course> cartCourses = [];

  final List<PaymentGateway> paymentGateway;

  Base(
    this.userStatus,
    this.mobileVerificationStatus,
    this.success,
    this.message,
    this.content,
    this.author,
    this.categoryBanner,
    this.courseCategories,
    this.announcements,
    this.questionAnswer,
    this.user,
    this.landingPage,
    this.myCourses,
    this.searchCourse,
    this.courseDetail,
    this.questionAnswers,
    this.cartCourses,
    this.paymentGateway,
  );

  factory Base.fromJson(Map<String, dynamic> json) => _$BaseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseToJson(this);
}
