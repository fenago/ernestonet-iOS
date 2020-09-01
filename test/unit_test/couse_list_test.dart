// import 'package:edustar/core/models/course/course.dart';
// import 'package:edustar/core/models/course_category.dart';
// // import 'package:edustar/core/models/edu_category.dart';
// import 'package:edustar/core/repositories/course/course_repository.dart';
// import 'package:edustar/core/view_models/home_view_model.dart';
// import 'package:flutter_test/flutter_test.dart';

// // class MockCourseRepository extends CourseRepository {
// //   @override
// //   Future<List<EduCategory>> getAllCategories() {
// //     return Future.value([
// //       EduCategory(1, 'Programming', 'active'),
// //       EduCategory(2, 'Business', 'inactive')
// //     ]);
// //   }

//   // @override
//   // Future<List<CourseCategory>> getAllCategoriesWithCourses() async {
//   //   final Course course = Course(
//   //     2,
//   //     3,
//   //     0,
//   //     0,
//   //     0,
//   //     'Accept',
//   //     'course_title_1528282367_3',
//   //     '23sfteacherId',
//   //     'sdfsf',
//   //     'require',
//   //     'flutter dev course',
//   //     'sfsdd.jpg',
//   //     'sfsfd.mp4',
//   //     'adsfsd',
//   //     'sfsdfd',
//   //     'sfsdfd',
//   //     'ssfd',
//   //   );
//   //   return Future.value([
//   //     CourseCategory(1, 'Business', [course, course]),
//   //     CourseCategory(2, 'IT & Software', [course, course, course]),
//   //     CourseCategory(4, 'Marketing', [course]),
//   //   ]);
//   // }
// // }

// void main() {
//   final HomeViewModel homeViewModel =
//       HomeViewModel(courseRepository: MockCourseRepository());

//   group('Get home categories and courses', () {
//     test('Home page should fetch a list of categories', () async {
//       await homeViewModel.getFullCorurseCategories();
//       expect(homeViewModel.homeCourseCategory.categories.length, 2);
//       expect(homeViewModel.homeCourseCategory.categories[0].id, 1);
//       expect(homeViewModel.homeCourseCategory.categories[0].name, 'Programming');
//       expect(homeViewModel.homeCourseCategory.categories[0].status, 'active');
//     });

//     test('Home page should fetch a list of courses with categories', () async {
//       await homeViewModel.getFullCorurseCategories();
//       expect(homeViewModel.homeCourseCategory.courseCategories.length, 3);
//       expect(homeViewModel.homeCourseCategory.courseCategories[0].id, 1);
//       expect(homeViewModel.homeCourseCategory.courseCategories[1].id, 2);
//       expect(homeViewModel.homeCourseCategory.courseCategories[2].id, 4);

//       expect(homeViewModel.homeCourseCategory.courseCategories[0].name, 'Business');
//       expect(homeViewModel.homeCourseCategory.courseCategories[1].name, 'IT & Software');
//       expect(homeViewModel.homeCourseCategory.courseCategories[2].name, 'Marketing');

//       expect(homeViewModel.homeCourseCategory.courseCategories[2].courses[0].teacherId, '23sfteacherId');
//     });
//   });
// }
