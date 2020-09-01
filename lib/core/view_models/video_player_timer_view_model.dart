import 'base_view_model.dart';

class VideoPlayerTimerViewModel extends BaseViewModel {
  String _duration = '';
  String _currentPosition = '';

  String get duration => _duration;
  String get currentPosition => _currentPosition;

  void updateTimer(String duration, String currentPosition) {
    _duration = duration;
    _currentPosition = currentPosition;
    notifyListeners();
  }
}
