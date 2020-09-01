import 'package:flutter/foundation.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/models/user.dart';
import '../../core/repositories/user/user_repository.dart';
import '../../core/view_models/base_view_model.dart';
import '../../locator.dart';
import '../services/local_storage_service.dart';

class ProfileViewModel extends BaseViewModel {
  final UserRepository _userRepository;
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  User _user;

  User get user => _user;

  ProfileViewModel({@required UserRepository userRepository}) : _userRepository = userRepository;

  void upateUser() {
    _user = _localStorageService.user;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    setState(ViewState.busy);
    try {
      await _userRepository.fetchUser();
      upateUser();
      setState(ViewState.idle);
    } on RepositoryException {
      setState(ViewState.error);
    }
  }

  Future<void> dummyLogout() async {
    setState(ViewState.busy);
    await Future.delayed(
      Duration(seconds: 2),
      () {
        _localStorageService.loggedIn = false;
        setState(ViewState.idle);
      },
    );
  }
}
