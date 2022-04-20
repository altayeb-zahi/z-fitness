import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/api/recipes_api.dart';
import 'package:z_fitness/managers/food_manager.dart';
import 'package:z_fitness/services/calories_service.dart';
import 'package:z_fitness/services/database_service.dart';
import 'package:z_fitness/services/shared_prefrences_service.dart';
import '../api/firestore_api.dart';
import '../services/firebase_authentication_service.dart';
import '../services/local_notifications_service.dart';
import '../services/push_notifications_service.dart';
import '../services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services and api
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<FirestoreApi>(() => FirestoreApi());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<FirebaseAuthenticationService>(
      () => FirebaseAuthenticationService());
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());
  locator.registerLazySingleton<CaloriesService>(() => CaloriesService());
  locator.registerLazySingleton<FoodApi>(() => FoodApi());
  locator.registerLazySingleton<RecipesApi>(() => RecipesApi());
  locator.registerLazySingleton<BottomSheetService>(() => BottomSheetService());
  locator.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<FoodManager>(() => FoodManager());


}
