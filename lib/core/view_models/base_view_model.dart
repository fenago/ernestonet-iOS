import 'package:flutter/material.dart';

enum ViewState {
  idle,
  busy,
  success,
  error,
}

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  bool _disposed = false;

  ViewState get state => _viewState;

  void setState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
