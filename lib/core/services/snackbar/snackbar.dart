import 'dart:async';

import 'package:edustar/core/models/snackbar/snackbar_request.dart';
import 'package:edustar/core/models/snackbar/snackbar_response.dart';
import 'package:edustar/core/services/snackbar/snackbar_base.dart';

class SnackBarService extends SnackBarServiceBase {
  Function(SnackBarRequest) _showSnackbarListener;
  Completer<SnackBarResponse> _snackbarCompleter;

  @override
  void registerSnackbarListener(Function showSnackbarListener) {
    _showSnackbarListener = showSnackbarListener;
  }

  Future<SnackBarResponse> showSnackBar({
    String title,
    String buttonTitle = 'Ok',
  }) {
    _snackbarCompleter = Completer<SnackBarResponse>();
    _showSnackbarListener(SnackBarRequest(
      title: title,
      buttonTitle: buttonTitle,
    ));

    return _snackbarCompleter.future;
  }

  @override
  void snackbarComplete(SnackBarResponse response) {
    _snackbarCompleter.complete(response);
    _snackbarCompleter = null;
  }

}