import 'package:edustar/ui/pages/account/privacy_about_terms_page.dart';
import 'package:edustar/ui/pages/search/search_category_page.dart';
import 'package:flutter/material.dart';

import 'core/constants/app_barrel.dart';
import 'core/models/course/course.dart';
import 'core/models/main_category.dart';
import 'core/models/question_answer.dart';
import 'core/models/user.dart';
import 'core/view_models/privacy_terms_about_view_model.dart';
import 'ui/pages/account/choose_language_page.dart';
import 'ui/pages/account/display_mode_page.dart';
import 'ui/pages/account/invite_friends_page.dart';
import 'ui/pages/account/profile_edit_page.dart';
import 'ui/pages/auth/forgot_password_page.dart';
import 'ui/pages/auth/initial_page.dart';
import 'ui/pages/auth/login_page.dart';
import 'ui/pages/auth/otp_page.dart';
import 'ui/pages/auth/register_page.dart';
import 'ui/pages/auth/reset_password_page.dart';
import 'ui/pages/cart/cart_page.dart';
import 'ui/pages/category/category_detail_page.dart';
import 'ui/pages/category/category_list_page.dart';
import 'ui/pages/course/about_course_page.dart';
import 'ui/pages/course/announcements_page.dart';
import 'ui/pages/course/category_course_list_page.dart';
import 'ui/pages/course/course_detail_page.dart';
import 'ui/pages/course/course_enrolled_started_page.dart';
import 'ui/pages/course/course_resource_page.dart';
import 'ui/pages/course/description_detail_page.dart';
import 'ui/pages/course/lecture_resource_page.dart';
import 'ui/pages/course/purchase_course_detail_page.dart';
import 'ui/pages/home_bottom_navigation_page.dart';
import 'ui/pages/instructor/instructor_bio_detailed_page.dart';
import 'ui/pages/instructor/instructor_profile_page.dart';
import 'ui/pages/my_course/question_answer_detail_page.dart';
import 'ui/pages/my_course/question_answer_page.dart';
import 'ui/pages/payments/payment_existing_card_page.dart';
import 'ui/pages/payments/payment_selection_page.dart';
import 'ui/pages/reviews_page.dart';
import 'ui/pages/search/search_course_page.dart';
import 'ui/widgets/internet_connection_error.dart';

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ViewRoutes.initial:
        return MaterialPageRoute(
          builder: (_) => InternetConnectionError(child: InitialPage()),
        );
      case ViewRoutes.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case ViewRoutes.register:
        final phoneData = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => RegisterPage(numberData: phoneData),
        );
      case ViewRoutes.otp:
        final mobileDatas = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpPage(mobileData: mobileDatas),
        );
      case ViewRoutes.forgotPassword:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordPage(mobileNumber: phoneNumber),
        );
      case ViewRoutes.resetPassword:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(phoneNumber: phoneNumber),
        );
      case ViewRoutes.home:
        return MaterialPageRoute(
          builder: (_) => HomeBottomNavigationPage(),
        );
      case ViewRoutes.profileEdit:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => ProfileEditPage(user: user),
        );
      case ViewRoutes.searchCourse:
        return MaterialPageRoute(
          builder: (_) => SearchCategoryPage(),
        );
      case ViewRoutes.courseDetail:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseDetailPage(course: course),
        );
      case ViewRoutes.purchaseCourseDetail:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => PurchaseCourseDetailPage(course: course),
        );
      case ViewRoutes.courseEnrolledStarted:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseEnrolledStartedPage(course: course),
        );
      case ViewRoutes.cart:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CartPage(course: course),
        );
      case ViewRoutes.review:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => ReviewsPage(course: course),
        );
      case ViewRoutes.questionAnswer:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => QuestionAnswerPage(course: course),
        );
      case ViewRoutes.questionAnswerDetail:
        final questionAnswer = settings.arguments as QuestionAnswer;
        return MaterialPageRoute(
          builder: (_) => QuestionAnswerDetailPage(questionAnswer: questionAnswer),
        );
      case ViewRoutes.chooseDisplayMode:
        return MaterialPageRoute(
          builder: (_) => DisplayModePage(),
        );
      case ViewRoutes.chooseLanguage:
        return MaterialPageRoute(
          builder: (_) => ChooseLanguagePage(),
        );
      case ViewRoutes.categoryCourseList:
        final categoryId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => CategoryCourseListPage(categoryId: categoryId),
        );
      case ViewRoutes.inviteFriends:
        return MaterialPageRoute(
          builder: (_) => InviteFriendsPage(),
        );
      case ViewRoutes.privacyAboutTerms:
        final appDetailType = settings.arguments as AppDetail;
        return MaterialPageRoute(
          builder: (_) => PrivacyAboutTermsPage(appDetail: appDetailType),
        );

      case ViewRoutes.instructorProfile:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => InstructorProfilePage(authorId: id),
        );
      case ViewRoutes.instructorBioDetailedProfile:
        final bio = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => InstructorBioDetailedPage(bio: bio),
        );
      case ViewRoutes.aboutCourse:
        final about = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AboutCoursePage(aboutDesc: about),
        );
      case ViewRoutes.lectureResources:
        return MaterialPageRoute(
          builder: (_) => LectureResourcesPage(),
        );
      case ViewRoutes.courseResources:
        return MaterialPageRoute(
          builder: (_) => CourseResourcesPage(),
        );
      case ViewRoutes.announcements:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => AnnouncementsPage(course: course),
        );
      case ViewRoutes.categoryList:
        final List<MainCategory> categories = settings.arguments as List<MainCategory>;
        return MaterialPageRoute(
          builder: (_) => CategoryListPage(categories: categories),
        );
      case ViewRoutes.categoryDetail:
        final category = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CategoryDetailPage(categoryId: category['id'], categoryName: category['name']),
        );
      case ViewRoutes.paymentSelection:
        final courses = settings.arguments as List<Course>;
        return MaterialPageRoute(
          builder: (_) => PaymentSelectionPage(courses: courses),
        );
      case ViewRoutes.paymentExistingCard:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => PaymentExistingCardPage(course: course),
        );
      case ViewRoutes.descriptionDetail:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => DescriptionDetailPage(
                  title: data['title'],
                  aboutDesc: data['desc'],
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route found for the name ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
