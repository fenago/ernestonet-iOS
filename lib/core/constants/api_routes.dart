class ApiRoutes {
  ApiRoutes._();

  static const String eduStarbaseUrl = 'https://abserve.tech/projects/edustar_pro/public/api/';
  static const String baseUrl = 'https://www.ernesto.net/api/';
  static const String mediaBaseUrl = 'https://www.ernesto.net/api/';

  // Auth
  static const String onboardCountryPicker = 'user/landingpage';
  static const String socialSignIn = 'user/socialmedia';
  static const String customerPhoneLogin = 'user/signinmobile';
  static const String userExist = 'user/phonenumvalidation?mobile=';
  static const String registration = 'user/registration';
  static const String otp = 'user/otpverification';
  static const String forgotPassword = 'user/forgotpassword';
  static const String changePassword = 'user/changepass';
  static const String resetPassword = 'user/resetpassword';

  // User
  static const String userProfile = 'user/profileview?user_id=';
  static const String updateProfile = 'user/editprofile';

  // Course
  static const String courses = 'course/courses?user_id=';
  static const String eduCategory = 'course/category';
  static const String categoryBasedCourses = 'course/categorybasedcourse?user_id=';
  static const String myCourses = 'course/mycourse?page=';
  static const String searchCourse = 'course/course_search?user_id=';
  static const String courseDetail = 'course/course_detail?course_id=';
  static const String deleteMyCourse = 'course/delete_course';
  static const String wishlist = 'course/wishlist?page=';
  static const String addWishlist = 'course/wishlist_add';
  static const String removeWishlist = 'course/wishlist_remove';
  static const String addToCart = 'course/add_cart';
  static const String removeFromCart = 'course/remove_cart';
  static const String cartCourses = 'course/view_cart?user_id=';
  static const String buyCourse = 'course/buy_now';
  static const String enrollFreeCourse = 'course/buy_now_free';
  static const String questionAnswer = 'course/learner_question_answer?c_id=';
  static const String postUpdateQuestionAnswer = 'course/learner_question_add';
  static const String deleteQuestionAnswer = 'course/learner_question_remove';
  static const String postAnswer = 'course/learner_answer_add';
  static const String deleteAnswer = 'course/learner_answer_remove';

  // Author
  static const String author = 'user/instructor_profile?author_id=';
  static const String announcement = 'user/announcement?author_id=';

  // App
  static const String termsOfServices = 'https://www.ernesto.net/terms_condition';
  static const String privacy = 'https://www.ernesto.net/privacy_policy';
  static const String about = 'https://www.ernesto.net/about/show';

  // Payment
  static const String paymentGateway = 'user/paymentgateway';
}
