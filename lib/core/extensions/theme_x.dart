import 'package:flutter/material.dart';

extension TextThemeContext on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;
}

extension ThemeContext on BuildContext {
  ThemeData theme() => Theme.of(this);
}
