

import '../../../app/router.dart';
import '../../base/authentication_view_model.dart';

class CreateAccountViewModel extends AuthenticationViewModel {
  CreateAccountViewModel() : super(successRoute: Routes.homeView);

  void navigateBack() => navigationService.goBack();
}
