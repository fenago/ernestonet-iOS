import 'dart:io';

import 'package:edustar/core/models/category_banner.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:edustar/core/models/main_category.dart';
import 'package:edustar/core/models/question_answer.dart';
import 'package:edustar/core/models/question_request.dart';

import '../../models/course_category.dart';

abstract class CourseRepositoryBase {
  Future<CategoryBanner> getCategoryBanner(Function(CategoryBanner) refreshedCategoryBannery);

  Future<List<CourseCategory>> getAllCategoriesWithCourses(Function(List<CourseCategory>) refreshedCourses);

  Future<List<Course>> getAllCategoryBasedCourses(int categoryId, int pageNo, int userId);

  Future<List<Course>> getAllMyCourses(int pageNo, Function(List<Course>) refreshedCourse);

  Future<List<Course>> getAllWishlistCourses(int pageNo, Function(List<Course>) refreshedCourse);

  Future<File> downloadVideo(String url, String subDirectory);

  Future<bool> addCourseToWishlist(Course course);

  Future<bool> removeCourseFromWishlist(int courseId);

  Future<bool> buyCourse(List<Course> courses, String transactionId);

  Future<List<Course>> getCartCourses();

  Future<bool> addCourseToCart(Course course);

  Future<bool> removeCourseFromCart(int cartId);

  Future<List<QuestionAnswer>> getQuestionAnswer(int courseId, String userId);

  Future<QuestionAnswer> postUpdateQuestion(QuestionRequest questionRequest);

  Future<bool> deleteQuestion(QuestionRequest questionRequest);

  Future<QuestionAnswer> postAnswer(QuestionRequest questionRequest);

  Future<bool> deleteAnswer(QuestionRequest questionRequest);
}
