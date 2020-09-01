import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/auth_exception.dart';
import '../utils/validators.dart';
import '../models/mobile_register.dart';
import '../services/auth/auth_service.dart';
import 'base_view_model.dart';

class RegisterViewModel extends BaseViewModel with Validators {
  final AuthService _authService;

  RegisterViewModel({@required AuthService authService}) : _authService = authService;

  Future<void> registerUser(MobileRegister mobileRegister) async {
    try {
      setState(ViewState.busy);
      await _authService.signUpWithPhoneNumber(mobileRegister);
      setState(ViewState.idle);
      return true;
    } on AuthException catch (e) {
      setState(ViewState.idle);
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
    }
  }
}
