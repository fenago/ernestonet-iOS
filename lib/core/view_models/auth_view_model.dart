import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/auth/auth_service.dart';
import '../../core/view_models/base_view_model.dart';
import '../constants/local_storage_keys.dart';
import '../models/user.dart';

enum AuthState {
  uninitialized,
  authenticated,
  unauthenticated,
}

class AuthViewModel extends BaseViewModel {
  final AuthService _authService;

  AuthState _authState = AuthState.uninitialized;

  AuthState get authState => _authState;

  AuthViewModel({@required AuthService authService}) : _authService = authService;

  void setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  Future<void> storeUser(User user) async {
    setState(ViewState.busy);
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(SharedPreferenceKeys.user, user.name);
      setState(ViewState.idle);
    } on Exception catch (e) {
      print('Login Error : ${e.toString()}');
      setState(ViewState.idle);
    }
  }

  Future<void> getUser(User user) async {
    setState(ViewState.busy);
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final name = sharedPreferences.getString(SharedPreferenceKeys.user);
      setState(ViewState.idle);
      return name;
    } on Exception catch (e) {
      print('Login Error : ${e.toString()}');
      setState(ViewState.idle);
    }
  }

  void checkAuth() async {
    final bool isLoggedIn = await _authService.isUserLoggedIn();
    _authState = isLoggedIn ? AuthState.authenticated : AuthState.unauthenticated;
    notifyListeners();
  }
}
