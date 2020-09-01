import 'package:edustar/core/constants/app_barrel.dart';
import 'package:edustar/core/services/local_storage_service.dart';
import 'package:edustar/core/view_models/auth_view_model.dart';
import 'package:edustar/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboard_container_page.dart';
import 'page_indicator.dart';

class OnboardPage extends StatefulWidget {
  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> with TickerProviderStateMixin {
  int currentPage = 0;
  bool lastPage = false;
  PageController _pageController;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
    animationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> onboardPages = <Widget>[];

    final onboards = locator<LocalStorageService>().landing.onboard;

    for (var onboard in onboards) {
      onboardPages.add(OnboardContainer(
        onboard: onboard,
      ));
    }
    return Container(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        PageView.builder(
            itemCount: onboardPages.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
                if (currentPage == onboardPages.length - 1) {
                  lastPage = true;
                  animationController.forward();
                } else {
                  lastPage = false;
                  animationController.reset();
                }
              });
            },
            itemBuilder: (context, index) {
              return onboardPages[index];
            }),
        Positioned(
          left: 15.0,
          bottom: 35.0,
          child: Container(
            width: 100.0,
            child: PageIndicator(currentPage, onboardPages.length),
          ),
        ),
        Positioned(
          right: 10.0,
          bottom: 10.0,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: lastPage
                ? SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      onPressed: () {
                        // Go to login Page
                        locator<LocalStorageService>().onboard = false;
                        context.read<AuthViewModel>().setAuthState(AuthState.unauthenticated);
                      },
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ]),
    );
  }
}
