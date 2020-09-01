import 'dart:io';

import 'package:edustar/core/models/category_banner.dart';
import 'package:edustar/core/models/course/search_course.dart';
import 'package:edustar/core/models/main_category.dart';
import 'package:edustar/core/models/question_answer.dart';
import 'package:edustar/core/models/question_request.dart';
import 'package:edustar/core/models/user.dart';
import 'package:edustar/core/services/local_storage_service.dart';

import '../../../locator.dart';
import '../../constants/api_routes.dart';
import '../../data_sources/course_category_data_source.dart';
import '../../exceptions/cache_exception.dart';
import '../../exceptions/network_exception.dart';
import '../../exceptions/repository_exception.dart';
import '../../models/course/course.dart';
import '../../models/course_category.dart';
import '../../repositories/course/course_repository_base.dart';
import '../../services/http/api_service.dart';
import '../../utils/network_helper.dart' as network_helper;

class CourseRepository implements CourseRepositoryBase {
  final ApiService apiService = locator<ApiService>();
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  final CourseCategoryDataSource _courseCategoryDataSource = locator<CourseCategoryDataSource>();

  @override
  Future<CategoryBanner> getCategoryBanner(Function(CategoryBanner) refreshedCategoryBannery) async {
    CategoryBanner categoryBanner;
    try {
      await _courseCategoryDataSource.init();
      categoryBanner = _courseCategoryDataSource.getCategoryBanner();
      apiService.getHttp(ApiRoutes.eduCategory).then((response) {
        categoryBanner = network_helper.decodeResponseBodyToBase(response).categoryBanner;
        _courseCategoryDataSource.cacheCategoryBanner(categoryBanner);
        refreshedCategoryBannery(categoryBanner);
      });
      print('Category Banner ****');
      return categoryBanner;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<List<CourseCategory>> getAllCategoriesWithCourses(Function(List<CourseCategory>) refreshedCourses) async {
    List<CourseCategory> courseCategories;
    try {
      await _courseCategoryDataSource.init();
      courseCategories = _courseCategoryDataSource.getCachedCategoriesWithCourses();
      User currentUser = _localStorageService.user;

      apiService.getHttp('${ApiRoutes.courses}${currentUser.id}').then((response) {
        courseCategories = network_helper.decodeResponseBodyToBase(response).courseCategories;
        _courseCategoryDataSource.cacheCategoriesWithCourses(courseCategories);
        refreshedCourses(courseCategories);
      });
      print('Course Categories ****');
      return courseCategories;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  // Course Detail List
  @override
  Future<List<Course>> getAllCategoryBasedCourses(int categoryId, int pageNo, int userId) async {
    try {
      final response = await apiService.getHttp(ApiRoutes.categoryBasedCourses + '$userId' + '&c_id=$categoryId' + '&page=$pageNo');
      final categoryCourses = network_helper.decodeResponseBodyToBase(response).myCourses;
      return categoryCourses;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  // My Course
  @override
  Future<List<Course>> getAllMyCourses(int pageNo, Function(List<Course>) refreshedCourse) async {
    List<Course> myCourses = [];
    try {
      await _courseCategoryDataSource.init();
      myCourses = _courseCategoryDataSource.getMyCourses();
      apiService.getHttp(ApiRoutes.myCourses + '$pageNo' + '&user_id=${_localStorageService.user.id}').then((response) {
        final newMyCourses = network_helper.decodeResponseBodyToBase(response).myCourses;
        newMyCourses.asMap().forEach((index, newMyCourse) {
          if (myCourses != null) {
            for (var myOldCourse in myCourses) {
              if (myOldCourse.id != newMyCourse.id) {
                myCourses.add(newMyCourse);
              }
            }
          }
          if (myCourses.isEmpty) {
            myCourses = newMyCourses;
          }
        });
        _courseCategoryDataSource.cacheMyCourses(myCourses);
        refreshedCourse(myCourses);
      });
      return myCourses;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<bool> buyCourse(List<Course> courses, String transactionId) async {
    try {
      final localStorageService = locator<LocalStorageService>();
      print('USER ID : ${localStorageService.user.id}');
      final response = await apiService.postHttp(ApiRoutes.buyCourse, {'user_id': localStorageService.user.id, 'transaction_id': transactionId});
      final isCourseBought = network_helper.decodeResponseBodyToBase(response).success;
      if (isCourseBought) {
        await _courseCategoryDataSource.cacheCartCourses([]);
        List<Course> alreadyBoughtCourses = _courseCategoryDataSource.getMyCourses();
        if (alreadyBoughtCourses != null) {
          alreadyBoughtCourses.addAll(courses);
        } else {
          alreadyBoughtCourses = courses;
        }
        await _courseCategoryDataSource.cacheMyCourses(alreadyBoughtCourses);
      }
      return isCourseBought;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<bool> enrollFreeCourse(Course course) async {
    try {
      final user = locator<LocalStorageService>().user;
      final response = await apiService.postHttp(ApiRoutes.enrollFreeCourse, {'user_id': user.id, 'course_id': course.id});
      final isCourseBought = network_helper.decodeResponseBodyToBase(response).success;
      if (isCourseBought) {
        await _courseCategoryDataSource.cacheSingleMyCourse(course);
      }
      return isCourseBought;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<Course> courseDetail(int courseId) async {
    try {
      final user = locator<LocalStorageService>().user;
      final response = await apiService.getHttp(ApiRoutes.courseDetail + '$courseId' + '&user_id=' + '${user.id}');
      final courseDetail = network_helper.decodeResponseBodyToBase(response).courseDetail;
      return courseDetail;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  // Search Course
  Future<List<SearchCourse>> searchCourses(String keyword) async {
    try {
      final userId = locator<LocalStorageService>().user.id;
      await _courseCategoryDataSource.init();
      final response = await apiService.getHttp(ApiRoutes.searchCourse + '$userId&keyword=$keyword');
      final myCourses = network_helper.decodeResponseBodyToBase(response).searchCourse;
      return myCourses;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<Course> getCourseWithId(int id) async {
    try {
      final userId = locator<LocalStorageService>().user.id;
      await _courseCategoryDataSource.init();
      final response = await apiService.getHttp(ApiRoutes.courseDetail + '$id&user_id=$userId');
      final course = network_helper.decodeResponseBodyToBase(response).courseDetail;
      return course;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  // Cart
  @override
  Future<List<Course>> getCartCourses() async {
    try {
      print('GET CART Called');
      await _courseCategoryDataSource.init();
      List<Course> cartCourses = _courseCategoryDataSource.getCartCourses();
      if (cartCourses == null) {
        final response = await apiService.getHttp(ApiRoutes.cartCourses + '${_localStorageService.user.id}');
        cartCourses = network_helper.decodeResponseBodyToBase(response).cartCourses;
        await _courseCategoryDataSource.cacheCartCourses(cartCourses);
      }
      return cartCourses;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  Future<void> clearAllCartCourses() async {
    await _courseCategoryDataSource.cacheCartCourses([]);
  }

  Future<bool> addCourseToCart(Course course) async {
    try {
      final data = {
        'user_id': _localStorageService.user.id,
        'course_id': course.id,
        'category_id': course.categoryId,
        'price': course.price,
        'discount_price': course.discountPrice,
      };
      final response = await apiService.postHttp(ApiRoutes.addToCart, data);
      final cartCourses = network_helper.decodeResponseBodyToBase(response).cartCourses;
      if (cartCourses != null) {
        // cart local
        await _courseCategoryDataSource.init();
        await _courseCategoryDataSource.cacheCartCourses(cartCourses);
      }
      return true;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> removeCourseFromCart(int cartId) async {
    try {
      final data = {
        'user_id': _localStorageService.user.id,
        'cart_id': cartId,
      };
      final response = await apiService.deleteHttp(ApiRoutes.removeFromCart, data);
      final cartCourses = network_helper.decodeResponseBodyToBase(response).cartCourses;
      if (cartCourses != null) {
        // cart local
        await _courseCategoryDataSource.init();
        await _courseCategoryDataSource.cacheCartCourses(cartCourses);
      }
      return true;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<File> downloadVideo(String url, String subDirectory) async {
    try {
      final file = await apiService.downloadFile(url, subDirectory);
      return file;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  // Wishlist
  @override
  Future<List<Course>> getAllWishlistCourses(int pageNo, Function(List<Course>) refreshedCourse) async {
    List<Course> wishlistCourses = [];
    try {
      await _courseCategoryDataSource.init();
      wishlistCourses = _courseCategoryDataSource.getWishlistCourses();
      apiService.getHttp(ApiRoutes.wishlist + '$pageNo' + '&user_id=${_localStorageService.user.id}').then((response) {
        final newWishlistCourses = network_helper.decodeResponseBodyToBase(response).myCourses;
        newWishlistCourses.asMap().forEach((index, newWishlistCourse) {
          if (wishlistCourses != null) {
            for (var oldWishlistCourse in wishlistCourses) {
              if (oldWishlistCourse.id != newWishlistCourse.id) {
                wishlistCourses.add(newWishlistCourse);
              }
            }
            if (wishlistCourses.isEmpty) {
              wishlistCourses = newWishlistCourses;
            }
          }
        });
        _courseCategoryDataSource.cacheWishlistCourses(wishlistCourses);
        refreshedCourse(wishlistCourses);
      });

      return wishlistCourses;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<bool> addCourseToWishlist(Course course) async {
    try {
      final data = {
        'user_id': _localStorageService.user.id,
        'c_id': course.id,
      };
      final response = await apiService.postHttp(ApiRoutes.addWishlist, data);
      final isAdded = network_helper.decodeResponseBodyToBase(response).success;
      if (isAdded) {
        // wishlist local
        await _courseCategoryDataSource.init();
        await _courseCategoryDataSource.cacheWishlistSingleCourse(course);
      }
      return true;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<bool> removeCourseFromWishlist(int courseId) async {
    try {
      final data = {
        'user_id': _localStorageService.user.id,
        'c_id': courseId,
      };
      final response = await apiService.deleteHttp(ApiRoutes.removeWishlist, data);
      final isRemoved = network_helper.decodeResponseBodyToBase(response).success;
      if (isRemoved) {
        await _courseCategoryDataSource.init();
        await _courseCategoryDataSource.removeWishlistCourse(courseId);
      }
      return isRemoved;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      print(e.message);
      throw RepositoryException(e.message);
    }
  }

  // Question and Answer
  @override
  Future<List<QuestionAnswer>> getQuestionAnswer(int courseId, String userId) async {
    try {
      final response = await apiService.getHttp(ApiRoutes.questionAnswer + '$courseId' + '&user_id=$userId');
      return network_helper.decodeResponseBodyToBase(response).questionAnswers;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<QuestionAnswer> postUpdateQuestion(QuestionRequest questionRequest) async {
    try {
      final response = await apiService.postHttp(ApiRoutes.postUpdateQuestionAnswer, questionRequest.toJson());
      return network_helper.decodeResponseBodyToBase(response).questionAnswer;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<bool> deleteQuestion(QuestionRequest questionRequest) async {
    try {
      final response = await apiService.deleteHttp(ApiRoutes.deleteQuestionAnswer, questionRequest.toJson());
      return network_helper.decodeResponseBodyToBase(response).success;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<QuestionAnswer> postAnswer(QuestionRequest questionRequest) async {
    try {
      final response = await apiService.postHttp(ApiRoutes.postAnswer, questionRequest.toJson());
      return network_helper.decodeResponseBodyToBase(response).questionAnswer;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<bool> deleteAnswer(QuestionRequest questionRequest) async {
    try {
      final response = await apiService.deleteHttp(ApiRoutes.deleteAnswer, questionRequest.toJson());
      return network_helper.decodeResponseBodyToBase(response).success;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
