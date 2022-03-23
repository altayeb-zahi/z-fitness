import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/services/user_service.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

class HeightSelectorViewModel extends BaseViewModel {
  num _height = locator<UserService>().currentUser!.height ?? 160.0;

  num get height => _height;

  void setHeight(double height) {
    _height = height;
    notifyListeners();
  }
}
