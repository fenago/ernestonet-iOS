import 'base_view_model.dart';

class LoginFormViewModel extends BaseViewModel {
  bool showPassword = false;

  void onEditingField(String value) {
    if (value.length == 10) {
      showPassword = true;
    } else {
      showPassword = false;
    }
    notifyListeners();
  }
}
