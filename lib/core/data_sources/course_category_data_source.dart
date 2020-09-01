import 'package:edustar/core/exceptions/cache_exception.dart';
import 'package:edustar/core/models/author.dart';
import 'package:edustar/core/models/category_banner.dart';
import 'package:edustar/core/models/course/benefit.dart';
import 'package:edustar/core/models/course/course.dart';
import 'package:edustar/core/models/course/course_include.dart';
import 'package:edustar/core/models/course/currency.dart';
import 'package:edustar/core/models/course/curriculum.dart';
import 'package:edustar/core/models/course/review.dart';
import 'package:edustar/core/models/course/topic.dart';
import 'package:edustar/core/models/main_category.dart';
import 'package:edustar/core/models/slider.dart';
import 'package:hive/hive.dart';

import '../../core/constants/local_storage_keys.dart';
import '../../core/models/course_category.dart';
import '../../locator.dart';

abstract class CourseCategoryDataSourceBase {
  Future<void> init();
  Future<void> cacheCategoryBanner(CategoryBanner categoryBanner);
  CategoryBanner getCategoryBanner();

  Future<void> cacheCategoriesWithCourses(List<CourseCategory> courseCategories);
  List<CourseCategory> getCachedCategoriesWithCourses();

  // My Enrolled Courses
  Future<void> cacheMyCourses(List<Course> myCourses);
  Future<void> cacheSingleMyCourse(Course course);
  List<Course> getMyCourses();

  // Wishlist Courses
  List<Course> getWishlistCourses();
  Future<void> cacheWishlistCourses(List<Course> wishlistCourses);
  Future<void> cacheWishlistSingleCourse(Course course);
  Future<void> removeWishlistCourse(int courseId);

  // Cart
  List<Course> getCartCourses();
  Future<void> cacheCartCourses(List<Course> cartCourses);
  Future<void> cacheCartSingleCourse(Course course);
}

class CourseCategoryDataSource implements CourseCategoryDataSourceBase {
  final _hiveService = locator<HiveInterface>();
  bool initialized = false;

  Box<CategoryBanner> _categoryBannerBox;
  Box<CourseCategory> _courseCategoriesBox;
  Box<Course> _myCourseBox;
  Box<Course> _wishlistCourseBox;
  Box<Course> _cartCourseBox;

  bool _isCategoryBannerBoxOpen;
  bool _isCourseCategoriesBoxOpen;
  bool _ismyCourseBoxOpen;
  bool _isWishlistCourseBoxOpen;
  bool _isCartCourseBoxOpen;

  @override
  Future<void> init() async {
    if (!initialized) {
      initialized = true;
      _hiveService.registerAdapter<CategoryBanner>(CategoryBannerAdapter());
      _hiveService.registerAdapter<MainCategory>(MainCategoryAdapter());
      _hiveService.registerAdapter<Slider>(SliderAdapter());
      _hiveService.registerAdapter<CourseCategory>(CourseCategoryAdapter());
      _hiveService.registerAdapter<Course>(CourseAdapter());
      _hiveService.registerAdapter<CourseInclude>(CourseIncludeAdapter());
      _hiveService.registerAdapter<Benefit>(BenefitAdapter());
      _hiveService.registerAdapter<Curriculum>(CurriculumAdapter());
      _hiveService.registerAdapter<Topic>(TopicAdapter());
      _hiveService.registerAdapter<Review>(ReviewAdapter());
      _hiveService.registerAdapter<Author>(AuthorAdapter());
      _hiveService.registerAdapter<Currency>(CurrencyAdapter());
    }

    _categoryBannerBox = await _hiveService.openBox(HiveDatabaseKeys.categoryBanner);
    _courseCategoriesBox = await _hiveService.openBox(HiveDatabaseKeys.courseCategory);
    _myCourseBox = await _hiveService.openBox(HiveDatabaseKeys.myCourse);
    _wishlistCourseBox = await _hiveService.openBox(HiveDatabaseKeys.wishlistCourse);
    _cartCourseBox = await _hiveService.openBox(HiveDatabaseKeys.cartCourse);

    _isCategoryBannerBoxOpen = _hiveService.isBoxOpen(HiveDatabaseKeys.categoryBanner);
    _isCourseCategoriesBoxOpen = _hiveService.isBoxOpen(HiveDatabaseKeys.courseCategory);
    _ismyCourseBoxOpen = _hiveService.isBoxOpen(HiveDatabaseKeys.myCourse);
    _isWishlistCourseBoxOpen = _hiveService.isBoxOpen(HiveDatabaseKeys.wishlistCourse);
    _isCartCourseBoxOpen = _hiveService.isBoxOpen(HiveDatabaseKeys.cartCourse);
  }

  Future<void> deleteAllHiveBox() async {
    await _categoryBannerBox.deleteFromDisk();
    await _courseCategoriesBox.deleteFromDisk();
    await _myCourseBox.deleteFromDisk();
    await _wishlistCourseBox.deleteFromDisk();
    await _cartCourseBox.deleteFromDisk();
  }

  @override
  Future<void> cacheCategoryBanner(CategoryBanner categoryBanner) async {
    if (_isCategoryBannerBoxOpen) {
      await _categoryBannerBox.clear();
      await _categoryBannerBox.add(categoryBanner);
    }
  }

  @override
  CategoryBanner getCategoryBanner() {
    if (_categoryBannerBox.isEmpty) {
      return null;
    }
    return _categoryBannerBox.values.toList()[0];
  }

  @override
  Future<void> cacheCategoriesWithCourses(List<CourseCategory> courseCategories) async {
    if (_isCourseCategoriesBoxOpen) {
      // Updating cart status
      final cartCourses = getCartCourses();

      // If Cart course is null, Reset all category course cart status to false by default.
      if (cartCourses == null) {
        if (courseCategories != null) {
          courseCategories.forEach((category) {
            category.courses.forEach((course) {
              course.cart = false;
            });
          });
        }
      }

      if (cartCourses != null && cartCourses.isNotEmpty) {
        for (var courseCategory in courseCategories) {
          for (var course in courseCategory.courses) {
            // Cart contains some courses
            for (var cartCourse in cartCourses) {
              if (course.id == cartCourse.id) {
                print('Cart Course found : ID ${cartCourse.id} == ${cartCourse.id}');
                course.cart = true;
                course.cartId = cartCourse.cartId;
                break;
              } else {
                course.cart = false;
                course.cartId = 0;
              }
            }
          }
        }
      }

      // Updating wishlist status to course category
      final wishlistCourses = getWishlistCourses();
      if (wishlistCourses != null && wishlistCourses.isNotEmpty) {
        for (var courseCategory in courseCategories) {
          for (var course in courseCategory.courses) {
            // Wishlist contains some courses
            for (var wishlistCourse in wishlistCourses) {
              if (course.id == wishlistCourse.id) {
                print('Wishlist Course found : ID ${course.id} == ${wishlistCourse.id}');
                course.wishlist = true;
                break;
              }
            }
          }
        }
      }

      // Updating mycourse enrolled status
      final myCourses = getMyCourses();
      if (myCourses != null && myCourses.isNotEmpty) {
        for (var courseCategory in courseCategories) {
          for (var course in courseCategory.courses) {
            for (var myCourse in myCourses) {
              if (course.id == myCourse.id) {
                print('My Course found : ID ${course.id} == ${myCourse.id}');
                course.cart = false;
                course.enrolled = true;
                break;
              }
            }
          }
        }
      }

      await _courseCategoriesBox.clear();
      if (courseCategories != null && courseCategories.isNotEmpty) {
        await _courseCategoriesBox.addAll(courseCategories);
      }
    }
  }

  @override
  List<CourseCategory> getCachedCategoriesWithCourses() {
    if (_courseCategoriesBox.isEmpty) {
      return null;
    }
    return _courseCategoriesBox.values.toList();
  }

  // MyCourse
  @override
  Future<void> cacheMyCourses(List<Course> myCourses) async {
    if (_ismyCourseBoxOpen) {
      await _myCourseBox.clear();
      await _myCourseBox.addAll(myCourses);

      // Updating course status and cart status in  after purchasing course category.
      List<CourseCategory> cachedCategoryCourses = getCachedCategoriesWithCourses();
      cacheCategoriesWithCourses(cachedCategoryCourses);
    }
  }

  @override
  Future<void> cacheSingleMyCourse(Course course) async {
    if (_ismyCourseBoxOpen) {
      // Changing the enrolled status to true
      final courseCategories = _courseCategoriesBox.values.toList();
      for (var courseCategory in courseCategories) {
        for (var courseObj in courseCategory.courses) {
          if (courseObj.id == course.id) {
            courseObj.enrolled = true;
            print('Found course : Enrolled status ${courseObj.enrolled} and Course ID : ${courseObj.id}');
          }
        }
      }
      cacheCategoriesWithCourses(courseCategories);

      // Adding the course into mycourse cache.
      final myCourses = getMyCourses();
      if (myCourses == null) {
        course.enrolled = true;
        await _myCourseBox.add(course);
      } else {
        myCourses.add(course);
        await _myCourseBox.clear();
        await _myCourseBox.addAll(myCourses);
      }
    } else {
      throw CacheException('My course box is not opened');
    }
  }

  @override
  List<Course> getMyCourses() {
    if (_myCourseBox.isEmpty) {
      return [];
    }
    return _myCourseBox.values.toList();
  }

  // Wishlist
  @override
  List<Course> getWishlistCourses() {
    if (_wishlistCourseBox.isEmpty) {
      return [];
    }
    return _wishlistCourseBox.values.toList();
  }

  @override
  Future<void> cacheWishlistCourses(List<Course> wishlistCourses) async {
    if (_isWishlistCourseBoxOpen) {
      await _wishlistCourseBox.clear();
      await _wishlistCourseBox.addAll(wishlistCourses);
    } else {
      throw CacheException('Wishlist box is not opened');
    }
  }

  @override
  Future<void> cacheWishlistSingleCourse(Course course) async {
    if (_isWishlistCourseBoxOpen) {
      final wishlistCourses = getWishlistCourses();

      if (wishlistCourses != null) {
        wishlistCourses.asMap().forEach((index, courseItem) {
          if (courseItem.id == course.id) {
            throw CacheException('Course already wishlisted');
          }
        });
      }

      // 1. Adding the course to wishlist cache
      course.wishlist = true;

      // 2. If cart contains any course then add their cart id and cart status to this wishlist course
      final cartCourses = getCartCourses();
      for (var cartCourse in cartCourses) {
        if (cartCourse.id == course.id) {
          course.cart = true;
          course.cartId = cartCourse.id;
        }
      }

      _wishlistCourseBox.add(course);

      // 3. For updating course in home course categories
      List<CourseCategory> cachedCategoryCourses = getCachedCategoriesWithCourses();
      cacheCategoriesWithCourses(cachedCategoryCourses);
    } else {
      throw CacheException('Wishlist box is not opened');
    }
  }

  @override
  Future<void> removeWishlistCourse(int courseId) async {
    if (_wishlistCourseBox.isNotEmpty) {
      _wishlistCourseBox.values.toList().asMap().forEach((index, course) {
        if (course.id == courseId) {
          print('removed');
          _wishlistCourseBox.deleteAt(index);
        }
      });

      // For updating course in home course categories (25 June)
      List<Course> wishlistCourses = getWishlistCourses();
      List<CourseCategory> cachedCategoryCourses = getCachedCategoriesWithCourses();

      // Updating wishlist status
      if (wishlistCourses != null) {
        for (var courseCategory in cachedCategoryCourses) {
          for (var course in courseCategory.courses) {
            for (var wishlistCourse in wishlistCourses) {
              if (course.id == wishlistCourse.id) {
                course.wishlist = false;
                break;
              }
            }
          }
        }
      }
      cacheCategoriesWithCourses(cachedCategoryCourses);
    }
  }

  // Cart
  @override
  List<Course> getCartCourses() {
    if (_cartCourseBox.isEmpty) {
      return [];
    }
    return _cartCourseBox.values.toList();
  }

  @override
  Future<void> cacheCartCourses(List<Course> cartCourses) async {
    if (_isCartCourseBoxOpen) {
      await _cartCourseBox.clear();
      await _cartCourseBox.addAll(cartCourses);

      // Updating wishlist's course cart status from Cart
      List<Course> wishlistCourses = getWishlistCourses();
      if (wishlistCourses != null) {
        for (var cartCourse in cartCourses) {
          for (var wishlistCourse in wishlistCourses) {
            if (cartCourse.id == wishlistCourse.id) {
              print('*** Wishlist CART ID **** : ${cartCourse.cartId}');
              wishlistCourse.cart = true;
              wishlistCourse.cartId = cartCourse.cartId;
              break;
            } else {
              wishlistCourse.cart = false;
              wishlistCourse.cartId = 0;
            }
          }
        }

        if (cartCourses.isEmpty) {
          wishlistCourses.forEach((wishlistCourse) {
            wishlistCourse.cart = false;
            wishlistCourse.cartId = 0;
          });
        }

        await cacheWishlistCourses(wishlistCourses);
      }

      // For updating course in home course categories
      List<CourseCategory> cachedCategoryCourses = getCachedCategoriesWithCourses();
      cacheCategoriesWithCourses(cachedCategoryCourses);
    } else {
      throw CacheException('Cart box is not opened');
    }
  }

  @override
  Future<void> cacheCartSingleCourse(Course course) async {
    if (_isCartCourseBoxOpen) {
      List<Course> cartCourses = getCartCourses();
      cartCourses.asMap().forEach((index, courseItem) {
        if (courseItem.id == course.id) {
          throw CacheException('Course already exists');
        }
      });
      _cartCourseBox.add(course);

      // For updating course in home course categories
      List<CourseCategory> cachedCategoryCourses = getCachedCategoriesWithCourses();
      cacheCategoriesWithCourses(cachedCategoryCourses);
    } else {
      throw CacheException('Cart course box is not opened');
    }
  }
}
