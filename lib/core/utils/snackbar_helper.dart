import 'package:edustar/core/services/snackbar/snackbar.dart';

import '../../locator.dart';

Future<bool> showSnackbar(String message) async {
  final snackBarService = locator<SnackBarService>();
  final result = await snackBarService.showSnackBar(
    title: message,
    buttonTitle: 'OK'
  );
  return result.confirmed;
}