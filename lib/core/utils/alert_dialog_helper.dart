import '../../locator.dart';
import '../services/dialog/dialog_service.dart';

Future<void> showErrorAlert(String message) async {
  final dialogService = locator<DialogService>();
  await dialogService.showDialog(
    title: 'Error',
    description: message,
  );
}

Future<bool> showAlert(String message) async {
  final dialogService = locator<DialogService>();
  final result = await dialogService.showDialog(
    title: null,
    description: message,
    buttonTitle: 'OK'
  );
  return result.confirmed;
}