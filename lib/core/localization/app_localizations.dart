import 'dart:convert';

import 'package:edustar/core/constants/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../localization_setup.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  Future<bool> load() async {
    // Load the language json file from assets/lang folder.
    // final path = 'assets/lang/ta.json';
    print('Current language code : ${locale.languageCode}');
    final path = 'assets/lang/${locale.languageCode}.json';
    final data = await rootBundle.loadString(path);
    final Map<String, dynamic> result = jsonDecode(data);

    _localizedStrings = result.map((key, value) => MapEntry(key, value));
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }

  // App Constants
  String get appTitle => translate(LocalizationKeys.appTitle);

  // Navigation Title
  String get register => translate(LocalizationKeys.register);
  String get otp => translate(LocalizationKeys.otp);
  String get forgotPassword => translate(LocalizationKeys.forgotPassword);
  String get resetPassword => translate(LocalizationKeys.resetPassword);
  String get myCourseNavTitle => translate(LocalizationKeys.myCourseNavTitle);
  String get wishlistNavTitle => translate(LocalizationKeys.wishlistNavTitle);
  String get cartNavTitle => translate(LocalizationKeys.cartNavTitle);
  String get editProfileNavTitle => translate(LocalizationKeys.editProfileNavTitle);
  String get categoriesNavTitle => translate(LocalizationKeys.categoriesNavTitle);
  String get instructorNavTitle => translate(LocalizationKeys.instructorNavTitle);
  String get aboutNavTitle => translate(LocalizationKeys.aboutNavTitle);
  String get aboutInstructorNavTitle => translate(LocalizationKeys.aboutInstructorNavTitle);
  String get announcementNavTitle => translate(LocalizationKeys.announcementNavTitle);
  String get inviteFriendsNavTitle => translate(LocalizationKeys.inviteFriendsNavTitle);
  String get chooseExistingCardsNavTitle => translate(LocalizationKeys.chooseExistingCardsNavTitle);

  String get inviteFriendsHeading => translate(LocalizationKeys.inviteFriendsHeading);
  String get inviteFriendsSubtitle => translate(LocalizationKeys.inviteFriendsSubtitle);

  // Login
  String get login => translate(LocalizationKeys.login);
  String get forgotPasswordLbl => translate(LocalizationKeys.forgotPasswordLbl);
  String get orLoginWith => translate(LocalizationKeys.orLoginWith);
  String get phoneNumberDesc => translate(LocalizationKeys.phoneNumberDesc);

  // Register
  String get registerDesc => translate(LocalizationKeys.registerDesc);

  // OTP
  String get resendOtp => translate(LocalizationKeys.resendOtp);
  String get timer => translate(LocalizationKeys.timer);
  String get otpDesc => translate(LocalizationKeys.otpDesc);

  //Forgot Password
  String get forgotPasswordDesc => translate(LocalizationKeys.forgotPasswordDesc);

  // Home
  String get homeTitle => translate(LocalizationKeys.homeTitle);
  String get categories => translate(LocalizationKeys.categories);

  // Course Detail
  String get courseIncludes => translate(LocalizationKeys.courseIncludes);
  String get whatWillILearn => translate(LocalizationKeys.whatWillILearn);
  String get description => translate(LocalizationKeys.description);
  String get requirements => translate(LocalizationKeys.requirements);
  String get curriculum => translate(LocalizationKeys.curriculum);
  String get createdBy => translate(LocalizationKeys.createdBy);
  String get coursesBy => translate(LocalizationKeys.coursesBy);
  String get studentFeedback => translate(LocalizationKeys.studentFeedback);

  // Purchased Course Detail
  String get lesson => translate(LocalizationKeys.lesson);
  String get about => translate(LocalizationKeys.about);
  String get more => translate(LocalizationKeys.more);
  String get discussion => translate(LocalizationKeys.discussion);
  String get questionAnswer => translate(LocalizationKeys.questionAnswer);
  String get questionDetail => translate(LocalizationKeys.questionDetail);
  String get aboutThisCourse => translate(LocalizationKeys.aboutThisCourse);
  String get shareThisCourse => translate(LocalizationKeys.shareThisCourse);
  String get readMore => translate(LocalizationKeys.readMore);
  String get students => translate(LocalizationKeys.students);
  String get courses => translate(LocalizationKeys.courses);
  String get ratings => translate(LocalizationKeys.ratings);

  // Cart
  String get addToCart => translate(LocalizationKeys.addToCart);
  String get addedToCart => translate(LocalizationKeys.addedToCart);
  String get addToWishlist => translate(LocalizationKeys.addToWishlist);
  String get addedToWishlist => translate(LocalizationKeys.addedToWishlist);
  String get remove => translate(LocalizationKeys.remove);
  String get seeAll => translate(LocalizationKeys.seeAll);
  String get seeMore => translate(LocalizationKeys.seeMore);
  String get buyNow => translate(LocalizationKeys.buyNow);
  String get buyAll => translate(LocalizationKeys.buyAll);
  String get enrollNow => translate(LocalizationKeys.enrollNow);
  String get emptyWishlist => translate(LocalizationKeys.emptyWishlist);
  String get emptyQuestion => translate(LocalizationKeys.emptyQuestion);
  String get emptyCourse => translate(LocalizationKeys.emptyCourse);
  String get viewProfile => translate(LocalizationKeys.viewProfile);
  String get review => translate(LocalizationKeys.review);
  String get reviews => translate(LocalizationKeys.reviews);
  String get free => translate(LocalizationKeys.free);
  String get light => translate(LocalizationKeys.light);
  String get dark => translate(LocalizationKeys.dark);

  // Home Bottom Navigation
  String get home => translate(LocalizationKeys.home);
  String get myCourse => translate(LocalizationKeys.myCourse);
  String get wishlist => translate(LocalizationKeys.wishlist);

  // Payment Method
  String get paymentMethodTitle => translate(LocalizationKeys.paymentMethodTitle);

  // Profile
  String get hello => translate(LocalizationKeys.hello);
  String get account => translate(LocalizationKeys.account);
  String get myCourses => translate(LocalizationKeys.myCourses);
  String get downloads => translate(LocalizationKeys.downloads);
  String get payments => translate(LocalizationKeys.payments);
  String get displayMode => translate(LocalizationKeys.displayMode);
  String get managePayment => translate(LocalizationKeys.managePayment);
  String get changeLanguage => translate(LocalizationKeys.changeLanguage);
  String get general => translate(LocalizationKeys.general);
  String get inviteFriends => translate(LocalizationKeys.inviteFriends);
  String get inviteFriendsNow => translate(LocalizationKeys.inviteFriendsNow);
  String get privacyPolicy => translate(LocalizationKeys.privacyPolicy);
  String get termsOfService => translate(LocalizationKeys.termsOfService);
  String get rateEduStar => translate(LocalizationKeys.rateEduStar);
  String get help => translate(LocalizationKeys.help);
  String get signout => translate(LocalizationKeys.signout);

  // APP PLACEHOLDER
  String get mobileNoPlaceholder => translate(LocalizationKeys.mobileNoPlaceholder);
  String get phoneNumberPlaceholder => translate(LocalizationKeys.phoneNumberPlaceholder);
  String get passwordPlaceholder => translate(LocalizationKeys.passwordPlaceholder);
  String get confirmPasswordPlaceholder => translate(LocalizationKeys.confirmPasswordPlaceholder);
  String get namePlaceholder => translate(LocalizationKeys.namePlaceholder);
  String get firstNamePlaceholder => translate(LocalizationKeys.firstNamePlaceholder);
  String get lastNamePlaceholder => translate(LocalizationKeys.lastNamePlaceholder);
  String get educationalPlaceholder => translate(LocalizationKeys.educationalPlaceholder);
  String get addressPlaceholder => translate(LocalizationKeys.addressPlaceholder);
  String get aboutPlaceholder => translate(LocalizationKeys.aboutPlaceholder);
  String get emailPlaceholder => translate(LocalizationKeys.emailPlaceholder);
  String get otpPlaceholder => translate(LocalizationKeys.otpPlaceholder);
  String get searchPlaceholder => translate(LocalizationKeys.searchPlaceholder);

  // APP BUTTON TITLES
  String get browseCourse => translate(LocalizationKeys.browseCourse);
  String get buyCourse => translate(LocalizationKeys.buyCourse);

  // APP ERRORS
  String get noInternetError => translate(LocalizationKeys.noInternetError);
  String get checkInternetError => translate(LocalizationKeys.checkInternetError);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    print('IS supported locale : ${locale.languageCode}');
    return supportedLocaleCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    print('LOAD locale : ${locale.languageCode}');
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
