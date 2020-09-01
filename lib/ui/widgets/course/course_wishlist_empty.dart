import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/media_query_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/view_models/home_bottom_navigation_view_model.dart';
import '../../shared/ui_helper.dart';

class CourseWishlistEmpty extends StatelessWidget {
  final String emptyImage;
  final String title;
  final String buttonTitle;

  const CourseWishlistEmpty({
    Key key,
    @required this.emptyImage,
    @required this.title,
    @required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(emptyImage, width: context.mediaQuerySize().width / 1, height: context.mediaQuerySize().width / 2),
          UIHelper.verticalSpaceLarge(),
          Text(title, style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.w400)),
          UIHelper.verticalSpaceLarge(),
          FormSubmitButton(
            title: buttonTitle,
            borderRadius: 0.0,
            onPressed: () {
              context.read<HomeBottomNavigationViewModel>().setBottomBarIndex(0);
            },
          ).paddingHorizontal(20.0),
        ],
      ),
    );
  }
}
