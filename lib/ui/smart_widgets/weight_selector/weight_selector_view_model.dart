import 'package:z_fitness/ui/base/base_view_model.dart';

class WeightSelectorViewModel extends BaseViewModel {
  int _weight = 70;
  int get weight => _weight;

  List<int> weightRange = List.generate(200, (index) => index + 40);

  void setWeightValue(int value) {
    _weight = value;
    notifyListeners();
  }
}
