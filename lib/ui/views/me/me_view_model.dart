import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

import '../../../api/firestore_api.dart';
import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../models/user.dart';
import '../../../services/calories_service.dart';
import '../../../services/firebase_authentication_service.dart';
import '../../../services/user_service.dart';

class MeViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();
  final _navigationService = locator<NavigationService>();
  final _caloriesService = locator<CaloriesService>();

  User get currentUser => locator<UserService>().currentUser!;

  String get userNameFromGoogleSign => locator<FirebaseAuthenticationService>()
      .currentUser!
      .displayName
      .toString();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUSerStream() =>
      _firestoreApi.getUserStream(userId: currentUser.id!);

  List<MeUi> _info = [];
  List<MeUi> get info => _info;

  initialiseUserInfo() {
    _info = <MeUi>[
      MeUi(
        title: 'Bmr',
        subtitle: _caloriesService.bmr.toString(),
        icon: Icons.eco,
      ),
      MeUi(
        title: 'Desired Weight',
        subtitle: currentUser.desiredWeight.toString() + ' kg',
        icon: Icons.emoji_emotions,
      ),
      MeUi(
        title: 'Activity Level',
        subtitle: currentUser.activityLevel!,
        icon: Icons.directions_run,
      ),
      MeUi(
        title: 'Daily Calories Need',
        subtitle: currentUser.dailyCaloriesGoal.toString() + ' kcal',
        icon: Icons.dining_sharp,
      ),
    ];
    notifyListeners();
  }

  void navigateToEditGoal() async {
    var userUpdatedHisInfo =
        await _navigationService.navigateTo(Routes.userInfoView);
    if (userUpdatedHisInfo) {
      // to update the info after user pop back
      await _caloriesService.syncCaloriesGoal(currentUser);
      await initialiseUserInfo();
      notifyListeners();
    }
  }
}

class MeUi {
  String title;
  String subtitle;
  IconData icon;
  MeUi({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
