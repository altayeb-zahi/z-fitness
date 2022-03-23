

import '../../../app/router.dart';
import '../../base/authentication_view_model.dart';

class LoginViewModel extends AuthenticationViewModel{
  LoginViewModel() : super(successRoute: Routes.homeView);

  void navigateToCreateAccount() =>
      navigationService.navigateTo(Routes.createAccountView);
}