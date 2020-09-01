import 'package:edustar/core/services/auth/auth_service.dart';
import 'package:edustar/core/services/http/api_service.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/core/view_models/splash_view_model.dart';
import 'package:edustar/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/media_query_x.dart';
import '../../../core/view_models/auth_view_model.dart';
import '../base_view.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // final authViewModel = context.read<AuthViewModel>();
    // Future.delayed(Duration(seconds: 3), () {
    //   authViewModel.checkAuth();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      model: SplashViewModel(authService: AuthService(apiService: context.watch<ApiService>())),
      onModelReady: (model) => model.getInitialData(context),
      builder: (context, model, _) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  AssetImages.appLogo,
                  width: context.mediaQuerySize().width / 1.5,
                  height: 250.0,
                ),
              ),
            ),
            // Spacer(),
            model.state == ViewState.busy ? _showProgressView() : Container(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _showProgressView() => Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: CircularProgressIndicator(), height: 20.0, width: 20.0),
            UIHelper.horizontalSpaceMedium(),
            Text('Loading..'),
          ],
        ),
      );
}
