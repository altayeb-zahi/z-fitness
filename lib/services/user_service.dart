import 'dart:async';

import 'package:z_fitness/services/calories_service.dart';

import '../api/firestore_api.dart';
import '../app/locator.dart';
import '../app/logger.dart';
import '../models/user.dart';
import 'firebase_authentication_service.dart';

class UserService {
  final _firestoreApi = locator<FirestoreApi>();
  final _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final _caloriesService = locator<CaloriesService>();

  final _userController = StreamController<User>.broadcast();
  StreamSink<User> get updateUserSink => _userController.sink;
  Stream<User> get userStream => _userController.stream;

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get hasLoggedInUser => _firebaseAuthenticationService.hasUser;

  Future<void> syncUserAccount() async {
    final firebaseUserId =
        _firebaseAuthenticationService.firebaseAuth.currentUser!.uid;

    log.v('Sync user $firebaseUserId');

    final userAccount = await _firestoreApi.getUser(userId: firebaseUserId);

    if (userAccount != null) {
      log.v('User account exists. Save as _currentUser');
      _currentUser = userAccount;
      // updateUserSink.add(_currentUser!);
      // _caloriesService.updateDailyCaloriesSink
      //     .add(userAccount.dailyCaloriesGoal!.round());
    }
  }

  Future<void> syncOrCreateUserAccount({required User user}) async {
    log.i('user:$user');

    await syncUserAccount();

    if (_currentUser == null) {
      log.v('We have no user account. Create a new user ...');
      await _firestoreApi.createUser(user: user);
      _currentUser = user;
      log.v('_currentUser has been saved');
    }
  }

  Future<void> updateUserInfo({required User user}) async {
    await _firestoreApi.updateUser(user: user);
    await syncUserAccount();
  }
}
