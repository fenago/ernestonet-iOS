import 'package:edustar/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../locator.dart';
import '../../shared/ui_helper.dart';

class HomeShimmerPage extends StatefulWidget {
  @override
  _HomeShimmerPageState createState() => _HomeShimmerPageState();
}

class _HomeShimmerPageState extends State<HomeShimmerPage> {
  final localStorageService = locator<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IgnorePointer(
          child: Shimmer.fromColors(
            baseColor: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
            highlightColor: localStorageService.darkMode ? Colors.grey[700] : Colors.grey[50],
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall(),
                          Container(
                            color: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
                            width: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      color: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: GridView.count(
                        crossAxisSpacing: 20.0,
                        crossAxisCount: 4,
                        children: List.generate(
                            8,
                            (index) => Chip(
                                  backgroundColor: localStorageService.darkMode ? Colors.grey[800] : Palette.appLightGreyColor,
                                  label: SizedBox(
                                    width: double.infinity,
                                    height: 35.0,
                                  ),
                                )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (index, child) => Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 140.0,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  color: Palette.appLightGreyColor,
                                )),
                                UIHelper.verticalSpaceSmall(),
                                Container(
                                  color: Palette.appLightGreyColor,
                                  height: 20.0,
                                ),
                                UIHelper.verticalSpaceSmall(),
                                Row(
                                  children: <Widget>[Expanded(child: Container(color: Palette.appLightGreyColor, height: 15.0)), SizedBox(height: 15.0, width: 60.0)],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
