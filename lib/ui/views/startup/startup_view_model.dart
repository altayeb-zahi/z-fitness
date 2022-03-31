import 'package:stacked_services/stacked_services.dart';

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

  Future<void> runStartupLogic() async {
    await _localNotifcationService.initialize();
    await _pushNotificationService.initialise();

    if (_userService.hasLoggedInUser) {
      log.v('We have a user session on disk. Sync the user profile ...');
      await _userService.syncUserAccount();

      final currentUser = _userService.currentUser;
      log.v('User sync complete. User profile: $currentUser');

      _navigationService.replaceWith(Routes.homeView);
    } else {
      log.v('No user on disk, navigate to the LoginView');
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
