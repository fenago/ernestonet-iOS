import 'package:edustar/core/models/landing.dart';

import '../../models/mobile_register.dart';
import '../../models/mobile_signin.dart';
import '../../models/base.dart';

abstract class AuthServiceBase {
  Future<void> signUpWithPhoneNumber(
    MobileRegister mobileRegister,
  );

  Future<void> signInWithPhoneNumber(MobileSignIn mobileSignIn);

  Future<void> signInWithGoogle();

  Future<void> signInWithFacebook();

  Future<String> signInWithApple();

  Future<Base> sendOTPVerification(String phoneNumber, String otp, String countryCode);

  Future<void> forgotPassword(String phoneNumber);

  Future<void> resetPassword(String newPassword, String confirmPassword, String mobileNumber);

  Future<Landing> getOnboardCountryCodeDatas();

  Future<void> signOut();

  Future<Base> checkUserExists(String phoneNumber);

  Future<bool> isUserLoggedIn();
}
