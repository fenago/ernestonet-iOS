import 'dart:async';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:edustar/core/models/email_signin.dart';
import 'package:edustar/core/models/landing.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import '../../constants/api_routes.dart';
import '../../constants/local_storage_keys.dart';
import '../../exceptions/auth_exception.dart';
import '../../exceptions/network_exception.dart';
import '../../models/base.dart';
import '../../models/mobile_register.dart';
import '../../models/mobile_signin.dart';
import '../../models/user.dart';
import '../../services/auth/auth_service_base.dart';
import '../../services/http/api_service.dart';
import '../../utils/network_helper.dart' as network_helper;
import '../local_storage_service.dart';

class AuthService extends AuthServiceBase {
  final ApiService _apiService;
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  AuthService({ApiService apiService}) : _apiService = apiService;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  @override
  Future<void> signUpWithPhoneNumber(MobileRegister mobileRegister) async {
    try {
      final response = await _apiService.postHttp(ApiRoutes.registration, mobileRegister.toJson());
      final user = network_helper.decodeResponseBodyToBase(response).user;
      _localStorageService.user = user;
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> signInWithPhoneNumber(MobileSignIn mobileSignIn) async {
    try {
      final response = await _apiService.postHttp(ApiRoutes.customerPhoneLogin, mobileSignIn.toJson());
      final user = network_helper.decodeResponseBodyToBase(response).user;
      _localStorageService.user = user;
      _localStorageService.loggedIn = true;
      _userController.add(user);
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<Landing> getOnboardCountryCodeDatas() async {
    try {
      final response = await _apiService.getHttp(ApiRoutes.onboardCountryPicker);
      final landingPage = network_helper.decodeResponseBodyToBase(response).landingPage;
      return landingPage;
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> signInWithFacebook() {
    return null;
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signIn();
      final emailSignIn = EmailSignIn(
        name: googleSignIn.currentUser.displayName,
        email: googleSignIn.currentUser.email,
        mobileToken: 'xxxxxxxxxxxxxxxxxxxxxxxxxxx',
        from: 'gmail',
        device: 'android',
      );
      final response = await _apiService.postHttp(ApiRoutes.socialSignIn, emailSignIn.toJson());
      final user = network_helper.decodeResponseBodyToBase(response).user;
      _localStorageService.user = user;
      _localStorageService.loggedIn = true;
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<String> signInWithApple() async {
    try {
      var email = '';
      final result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          print(result.credential.user);
          email = result.credential.email;
          break;
        case AuthorizationStatus.error:
          print("Sign in failed: ${result.error.localizedDescription}");
          break;
        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
      return email;
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<Base> sendOTPVerification(String phoneNumber, String otp, String countryCode) async {
    try {
      final response = await _apiService.postHttp(ApiRoutes.otp, {
        'mobile': phoneNumber,
        'phone_otp': otp,
        'country_code': countryCode,
      });
      return network_helper.decodeResponseBodyToBase(response);
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<Base> forgotPassword(String phoneNumber) async {
    try {
      final response = await _apiService.postHttp(ApiRoutes.forgotPassword, {'mobile': phoneNumber});
      return network_helper.decodeResponseBodyToBase(response);
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<Base> resetPassword(String newPassword, String confirmPassword, String mobileNumber) async {
    try {
      final response = await _apiService.postHttp(ApiRoutes.resetPassword, {
        'mobile': mobileNumber,
        'password': newPassword,
        'confirmpassword': confirmPassword,
        'phone_otp': '12345',
      });
      return network_helper.decodeResponseBodyToBase(response);
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(SharedPreferenceKeys.loginStatus);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _localStorageService.loggedIn;
  }

  @override
  Future<Base> checkUserExists(String phoneNumber) async {
    try {
      final response = await _apiService.getHttp(ApiRoutes.userExist + phoneNumber);
      return network_helper.decodeResponseBodyToBase(response);
    } on NetworkException catch (e) {
      throw AuthException(e.message);
    }
  }
}
