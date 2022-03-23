

import 'package:get_it/get_it.dart';
import 'package:z_fitness/services/calories_service.dart';

import '../api/firestore_api.dart';
import '../services/firebase_authentication_service.dart';
import '../services/local_notifications_service.dart';
import '../services/navigation_service.dart';
import '../services/push_notifications_service.dart';
import '../services/user_service.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  // services and api
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<FirestoreApi>(() => FirestoreApi());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<FirebaseAuthenticationService>(() => FirebaseAuthenticationService());
  locator.registerLazySingleton<PushNotificationService>(() => PushNotificationService());
  locator.registerLazySingleton<LocalNotificationService>(() => LocalNotificationService());
  locator.registerLazySingleton<CaloriesService>(() => CaloriesService());


}