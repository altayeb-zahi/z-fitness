import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/services/calories_service.dart';
import 'package:z_fitness/services/database_service.dart';

import '../../../app/locator.dart';
import '../../../app/logger.dart';
import '../../../app/router.dart';
import '../../../services/local_notifications_service.dart';
import '../../../services/push_notifications_service.dart';
import '../../../services/user_service.dart';
import '../../base/base_view_model.dart';

class StartupViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _pushNotificationService = locator<PushNotificationService>();
  final _localNotifcationService = locator<LocalNotificationService>();
  final _databaseService = locator<DatabaseService>();

  Future<void> runStartupLogic() async {
    await _localNotifcationService.initialize();
    await _pushNotificationService.initialise();
    await _databaseService.initialise();

    if (_userService.hasLoggedInUser) {
      log.v('We have a user session on disk. Sync the user profile ...');
      await _userService.syncUserAccount();

      final currentUser = _userService.currentUser;
      log.v('User sync complete. User profile: $currentUser');

      if (currentUser!.hasWeightInfo) {
        _navigationService.replaceWith(Routes.homeView);
      } else {
        log.v('user did not add his weight informations');

        _navigationService.replaceWith(Routes.userInfoView);
      }
    } else {
      log.v('No user on disk, navigate to the LoginView');
      await Future.delayed(Duration(seconds: 3));
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
