import 'package:edustar/core/view_models/base_view_model.dart';

class PlayerRotationViewModel extends BaseViewModel {
  bool isFullScreen = false;

  void toggleFullscreen() {
    isFullScreen = !isFullScreen;
    notifyListeners();
  }
}
