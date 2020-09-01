import 'dart:async';

import '../../models/alert/alert_request.dart';
import '../../models/alert/alert_response.dart';
import '../../services/dialog/dialog_service_base.dart';

class DialogService extends DialogServiceBase {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  @override
  void registerDialogListener(Function showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));

    return _dialogCompleter.future;
  }

  @override
  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}