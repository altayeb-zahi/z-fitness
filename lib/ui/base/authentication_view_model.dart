import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../app/logger.dart';
import '../../models/user.dart';
import '../../services/firebase_authentication_service.dart';
// import '../../services/navigation_service.dart';
import '../../services/user_service.dart';
import 'base_view_model.dart';

abstract class AuthenticationViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  final navigationService = locator<NavigationService>();

  final firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final String successRoute;
  AuthenticationViewModel({required this.successRoute});

  String? _validationMessage;
  String? get validationMessage => _validationMessage;

  Future createAccountWithEmail(
      {required String email,
      required String passowrd,
      String? username}) async {
    setBusy(true);
    try {
      final result = await firebaseAuthenticationService.createAccountWithEmail(
          email: email, password: passowrd);

      await _handleAuthenticationResponse(result, username: username);
    } catch (e) {
      log.e(e.toString());
      _validationMessage = e.toString();
    }
    setBusy(false);
  }

  Future loginWithEmail(
      {required String email, required String passowrd}) async {
    setBusy(true);
    try {
      final result = await firebaseAuthenticationService.loginWithEmail(
          email: email, password: passowrd);

      await _handleAuthenticationResponse(result);
    } catch (e) {
      log.e(e.toString());
      _validationMessage = e.toString();
    }
    setBusy(false);

  }

  Future<void> useGoogleAuthentication() async {
    final result = await firebaseAuthenticationService.signInWithGoogle();
    await _handleAuthenticationResponse(result);
  }

  Future<void> useAppleAuthentication() async {
    final result = await firebaseAuthenticationService.signInWithApple(
      appleClientId: '',
      appleRedirectUri: '',
    );
    await _handleAuthenticationResponse(result);
  }

  /// Checks if the result has an error. If it doesn't we navigate to the success view
  /// else we show the friendly validation message.
  Future<void> _handleAuthenticationResponse(
      FirebaseAuthenticationResult authResult,
      {String? username}) async {
    log.v('authResult.hasError:${authResult.hasError}');

    if (!authResult.hasError && authResult.user != null) {
      final user = authResult.user!;

      final _userToken = await FirebaseMessaging.instance.getToken();

      await userService.syncOrCreateUserAccount(
        user: User(
            id: user.uid,
            email: user.email,
            name: username ?? user.displayName ?? 'user',
            token: _userToken),
      );

      // navigate to success route
      navigationService.replaceWith(successRoute);
    } else {
      if (!authResult.hasError && authResult.user == null) {
        log.wtf(
            'We have no error but the uer is null. This should not be happening');
      }

      log.w('Authentication Failed: ${authResult.errorMessage}');

      _validationMessage = authResult.errorMessage;

      notifyListeners();
    }
  }
}
