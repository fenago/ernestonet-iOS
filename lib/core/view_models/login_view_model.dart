import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:edustar/core/models/landing.dart';
import 'package:edustar/core/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';

import '../../core/exceptions/auth_exception.dart';
import '../../core/models/base.dart';
import '../../core/models/mobile_signin.dart';
import '../../core/services/auth/auth_service.dart';
import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../../core/view_models/base_view_model.dart';
import '../../locator.dart';
import '../utils/validators.dart';

class LoginViewModel extends BaseViewModel with Validators {
  final AuthService _authService;
  bool userExist = false;
  bool isPhoneNumberVerified = false;
  bool isAppleSignInAvailable = false;
  String email = '';

  LoginViewModel({@required AuthService authService}) : _authService = authService;

  void setUser(Base base) {
    userExist = base.userStatus;
    isPhoneNumberVerified = base.mobileVerificationStatus;
    notifyListeners();
  }

  Future<void> checkAppleSiginInAvailable() async {
    isAppleSignInAvailable = await AppleSignIn.isAvailable();
    notifyListeners();
  }

  void resetUserExistPhoneNumberVerified() {
    userExist = false;
    isPhoneNumberVerified = false;
    notifyListeners();
  }

  Future<void> loginWithPhoneNumber(MobileSignIn mobileSignIn) async {
    setState(ViewState.busy);
    try {
      await _authService.signInWithPhoneNumber(mobileSignIn);
      setState(ViewState.idle);
    } on AuthException catch (e) {
      print('Login Error : ${e.message}');
      setState(ViewState.idle);
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } on AuthException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
    }
  }

  Future<void> signInWithApple() async {
    setState(ViewState.busy);
    try {
      email = await _authService.signInWithApple();
    } on AuthException catch (e) {
      alert_helper.showErrorAlert(e.message);
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<void> checkUserExists(String phoneNumber) async {
    setState(ViewState.busy);
    try {
      final baseObj = await _authService.checkUserExists(phoneNumber);
      setUser(baseObj);
      setState(ViewState.idle);
    } on AuthException catch (e) {
      setState(ViewState.idle);
      setState(ViewState.error);
      print(e.message);
    }
  }
}
