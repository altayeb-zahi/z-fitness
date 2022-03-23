import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/services/user_service.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';


class GenderSelectorViewModel extends BaseViewModel {
  final _currentUser = locator<UserService>().currentUser;

  bool maleIsSelected = false;
  bool femaleIsSelected = false;

  void onModelReady() {
    if (_currentUser?.gender != null) {
      // user is updating his info
      if (_currentUser?.gender == "male") {
        onMaleSelected();
      } else {
        onFemaleSelected();
      }
    }
  }

  void onMaleSelected() {
    maleIsSelected = true;
    femaleIsSelected = false;
    notifyListeners();
  }

  void onFemaleSelected() {
    maleIsSelected = false;
    femaleIsSelected = true;
    notifyListeners();
  }
}
