import '../../models/snackbar/snackbar_request.dart';
import '../../models/snackbar/snackbar_response.dart';

abstract class SnackBarServiceBase {
  void registerSnackbarListener(Function(SnackBarRequest) showSnackbarListener);
  void snackbarComplete(SnackBarResponse response);
}