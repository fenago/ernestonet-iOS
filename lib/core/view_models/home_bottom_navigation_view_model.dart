import 'base_view_model.dart';

class HomeBottomNavigationViewModel extends BaseViewModel {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setBottomBarIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
