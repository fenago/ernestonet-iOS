import 'dart:io';

import 'package:edustar/core/exceptions/auth_exception.dart';
import 'package:edustar/core/models/landing.dart';
import 'package:edustar/core/services/auth/auth_service.dart';
import 'package:edustar/core/utils/validators.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../../locator.dart';
import '../exceptions/repository_exception.dart';
import '../models/user.dart';
import '../repositories/user/user_repository.dart';
import '../services/local_storage_service.dart';
import 'base_view_model.dart';

class ProfileEditViewModel extends BaseViewModel with Validators {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  UserRepository _userRepository;

  ProfileEditViewModel({
    @required UserRepository userRepository,
  }) : _userRepository = userRepository;

  void _setLanding(Landing landing) {
    locator<LocalStorageService>().landing = landing;
    notifyListeners();
  }

  Future<void> getInitialData(AuthService authService) async {
    try {
      final landing = await authService.getOnboardCountryCodeDatas();
      _setLanding(landing);
    } on AuthException catch (e) {
      alert_helper.showErrorAlert(e.message);
    }
  }

  Future<bool> updateUserProfile(User user, File file) async {
    setState(ViewState.busy);
    try {
      final updatedUser = await _userRepository.updateUser(user, file);
      _localStorageService.user = updatedUser;
      setState(ViewState.idle);
      return true;
    } on RepositoryException catch (e) {
      setState(ViewState.error);
      alert_helper.showErrorAlert(e.message);
      return false;
    }
  }
}
