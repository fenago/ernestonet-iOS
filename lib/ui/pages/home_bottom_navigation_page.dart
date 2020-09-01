import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/palette.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/view_models/home_bottom_navigation_view_model.dart';
import '../../core/extensions/theme_x.dart';
import '../../locator.dart';
import 'account/account_page.dart';
import 'home/home_page.dart';
import 'my_course/my_course_page.dart';
import 'wishlist/whishlist_page.dart';

class HomeBottomNavigationPage extends StatefulWidget {
  @override
  _HomeBottomNavigationPageState createState() => _HomeBottomNavigationPageState();
}

class _HomeBottomNavigationPageState extends State<HomeBottomNavigationPage> {
  final List<Widget> _children = [
    HomePage(),
    MyCoursePage(),
    WishListPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final localStorageService = locator<LocalStorageService>();

    return Consumer<HomeBottomNavigationViewModel>(
      builder: (context, model, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: _children[model.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Palette.appColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: localStorageService.darkMode ? Colors.grey[700] : Colors.white,
            selectedLabelStyle: context.textTheme().subtitle2.copyWith(fontSize: 13.0),
            unselectedLabelStyle: context.textTheme().subtitle2.copyWith(fontSize: 13.0),
            onTap: (index) {
              onTabBarTapped(index, model);
            },
            currentIndex: model.selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 23.0),
                title: Text(locale.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outline, size: 23.0),
                title: Text(locale.myCourse),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border, size: 23.0),
                title: Text(locale.wishlist),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 23.0),
                title: Text(locale.account),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabBarTapped(int index, HomeBottomNavigationViewModel model) {
    model.setBottomBarIndex(index);
  }
}
