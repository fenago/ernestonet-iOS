import 'package:edustar/core/models/landing.dart';
import 'package:edustar/core/services/local_storage_service.dart';
import 'package:edustar/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../exceptions/auth_exception.dart';
import '../utils/validators.dart';
import '../models/mobile_register.dart';
import '../services/auth/auth_service.dart';
import 'auth_view_model.dart';
import 'base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  final AuthService _authService;

  SplashViewModel({@required AuthService authService}) : _authService = authService;

  void _setLanding(Landing landing, BuildContext context) {
    locator<LocalStorageService>().landing = landing;
    context.read<AuthViewModel>().checkAuth();
  }

  Future<void> getInitialData(BuildContext context) async {
    try {
      setState(ViewState.busy);
      final landing = await _authService.getOnboardCountryCodeDatas();
      _setLanding(landing, context);
    } on AuthException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
    } finally {
      setState(ViewState.idle);
    }
  }
}
