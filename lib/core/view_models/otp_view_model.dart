import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../../locator.dart';
import '../exceptions/auth_exception.dart';
import '../utils/validators.dart';
import '../services/auth/auth_service.dart';
import '../services/local_storage_service.dart';
import 'base_view_model.dart';

class OtpViewModel extends BaseViewModel with Validators {
  final AuthService _authService;
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  OtpViewModel({@required AuthService authService}) : _authService = authService;

  Future<void> sendOtpVerification(String phoneNumber, String otp, String countryCode) async {
    try {
      setState(ViewState.busy);
      final base = await _authService.sendOTPVerification(phoneNumber, otp, countryCode);
      if (base.success) {
        _localStorageService.user = base.user;
        _localStorageService.loggedIn = true;
      }
      setState(ViewState.idle);
    } on AuthException catch (e) {
      setState(ViewState.idle);
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
    }
  }
}
