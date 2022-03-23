import 'package:z_fitness/ui/base/base_view_model.dart';

class IndexTrackingViewModel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
