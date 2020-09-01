import '../../models/alert/alert_request.dart';
import '../../models/alert/alert_response.dart';

abstract class DialogServiceBase {
  void registerDialogListener(Function(AlertRequest) showDialogListener);
  void dialogComplete(AlertResponse response);
}