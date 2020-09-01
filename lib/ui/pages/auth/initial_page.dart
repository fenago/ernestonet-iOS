import 'package:edustar/core/services/local_storage_service.dart';
import 'package:edustar/locator.dart';
import 'package:edustar/ui/pages/onboard/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/view_models/auth_view_model.dart';
import 'login_page.dart';
import 'splash_page.dart';
import '../home_bottom_navigation_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthViewModel>();
    final isOnboard = locator<LocalStorageService>().onboard;
    switch (authProvider.authState) {
      case AuthState.uninitialized:
        return SplashPage();
      case AuthState.authenticated:
        return HomeBottomNavigationPage();
      default:
        return isOnboard ? OnboardPage() : LoginPage();
    }
  }
}
