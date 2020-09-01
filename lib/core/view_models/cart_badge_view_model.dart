import 'package:flutter/foundation.dart';

import '../exceptions/repository_exception.dart';
import '../repositories/course/course_repository.dart';

class CartBadgeViewModel extends ChangeNotifier {
  int courseCount = 0;
  final _courseRepository = CourseRepository();

  CartBadgeViewModel() {
    getCartCourses();
  }

  void updateCartCourseCount(int value) {
    courseCount = value;
    notifyListeners();
  }

  Future<void> getCartCourses() async {
    try {
      final cartCourses = await _courseRepository.getCartCourses();
      updateCartCourseCount(cartCourses.length);
    } on RepositoryException catch (e) {
      print('Error : ${e.message}');
    }
  }

  Future<void> clearCartCourses() async {
    try {
      await _courseRepository.clearAllCartCourses();
    } on RepositoryException catch (e) {
      print('Error : ${e.message}');
    }
  }
}
