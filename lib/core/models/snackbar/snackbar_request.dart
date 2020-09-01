import 'package:flutter/foundation.dart';

class SnackBarRequest {
  final String title;
  final String buttonTitle;

  SnackBarRequest({
    @required this.title,
    @required this.buttonTitle,
  });
}
