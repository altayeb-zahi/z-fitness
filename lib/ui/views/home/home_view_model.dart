import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/services/user_service.dart';
import 'package:z_fitness/ui/base/index_tracking_view_model.dart';

// import '../../../services/navigation_service.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();
  final _currentUser = locator<UserService>().currentUser;

  void onModelReady() {
    if (!_currentUser!.hasWeightInfo) {
      _navigationService.navigateTo(Routes.userInfoView);
    }
  }
}
