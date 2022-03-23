import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/services/user_service.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

class ActivityLevelSelectorViewModel extends BaseViewModel {
  String _activityLevel =
      locator<UserService>().currentUser!.activityLevel ?? 'not active';
      
  String get activityLevel => _activityLevel;

  List<String> activityLevels = [
    'not active',
    'lightly active',
    'active',
    'very active',
  ];

  void setActitvityLevel(String activityLevel) {
    _activityLevel = activityLevel;
    notifyListeners();
  }
}
