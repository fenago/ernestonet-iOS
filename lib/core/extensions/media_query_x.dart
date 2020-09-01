import 'package:flutter/material.dart';

extension MediaQueryContext on BuildContext {
  MediaQueryData mediaQuery() => MediaQuery.of(this);
}

extension MediaQuerySize on BuildContext {
  Size mediaQuerySize() => MediaQuery.of(this).size;
}
