import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

import '../../../api/firestore_api.dart';
import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../models/user.dart';
import '../../../services/firebase_authentication_service.dart';
import '../../../services/user_service.dart';

class MeViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();
  final _navigationService = locator<NavigationService>();
  final firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  User get currentUser => locator<UserService>().currentUser!;

  String get userNameFromGoogleSign => locator<FirebaseAuthenticationService>()
      .currentUser!
      .displayName
      .toString();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUSerStream() =>
      _firestoreApi.getUserStream(userId: currentUser.id!);

  void navigateToEditGoal() =>
      _navigationService.navigateTo(Routes.userInfoView);

  logout() {
    firebaseAuthenticationService.logout();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  String getAge(String dateOfBirth) {
    String _datePattern = "dd-MM-yyyy";
    DateTime _birthDate = DateFormat(_datePattern).parse(dateOfBirth);
    DateTime _today = DateTime.now();
    int _yearDiff = _today.year - _birthDate.year;
    return _yearDiff.toString();
  }
}
