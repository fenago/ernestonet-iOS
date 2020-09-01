import 'package:flutter/material.dart';

extension PaddingWidget on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingVertical(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  Widget paddingHorizontal(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Widget paddingVerticalHorizontal(double verticalPadding, double horizontalPadding) => Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        child: this,
      );
}
