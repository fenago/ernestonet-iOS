import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../locator.dart';
import '../../shared/ui_helper.dart';

class CourseListShimmerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localStorageService = locator<LocalStorageService>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: IgnorePointer(
            child: Container(
              child: ListView.builder(
                itemCount: 18,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  color: context.theme().scaffoldBackgroundColor,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
                    highlightColor: localStorageService.darkMode ? Colors.grey[700] : Colors.grey[50],
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          color: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
                        ),
                        UIHelper.horizontalSpaceMedium(),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(height: 30.0, color: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor),
                              UIHelper.verticalSpaceMedium(),
                              Container(height: 15.0, color: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor),
                              UIHelper.verticalSpaceSmall(),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 15.0,
                                        color: Palette.appLightGreyColor,
                                      ),
                                    ),
                                    SizedBox(width: 80.0)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
