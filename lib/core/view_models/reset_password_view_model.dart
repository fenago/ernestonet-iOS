import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/auth_exception.dart';
import '../utils/validators.dart';
import '../services/auth/auth_service.dart';
import 'base_view_model.dart';

class ResetPasswordViewModel extends BaseViewModel with Validators {
  final AuthService _authService;

  ResetPasswordViewModel({@required AuthService authService}) : _authService = authService;

  Future<void> resetPassword(String newPassword, String confirmPassword, String mobileNumber) async {
    try {
      setState(ViewState.busy);
      final passwordResetStatus = await _authService.resetPassword(newPassword, confirmPassword, mobileNumber);
      setState(ViewState.idle);
      return passwordResetStatus.success;
    } on AuthException catch (e) {
      setState(ViewState.idle);
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
    }
  }
}
