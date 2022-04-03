import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/calories_details.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';
import '../../../api/firestore_api.dart';
import '../../../app/locator.dart';
import '../../../models/user.dart';
import '../../../services/user_service.dart';

//TODO when upload recipe to firestore and navigate back the currentIndex shoud go back to 0

class DiaryViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();

  final _navigationService = locator<NavigationService>();

  String _formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  DateTime? _selectedDay = DateTime.now();
  DateTime? get selectedDay => _selectedDay;

  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;

  CaloriesDetails _caloriesDetails = CaloriesDetails();
  CaloriesDetails get caloriesDetails => _caloriesDetails;

  User get currentUser => locator<UserService>().currentUser!;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;

    _formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDay!);

    getCaloriesDetails();
    _getTheFoodConsumedInSpecificDay();

    notifyListeners();
  }

  void getCaloriesDetails() {
    //TODO find the best way to cancel the stream
    _firestoreApi
        .getCaloriesDetailsForSpecificDay(
            userId: currentUser.id!, date: _formattedDate)
        .listen((calories) {
      if (calories.exists) {
        _caloriesDetails = CaloriesDetails.fromMap(calories.data()!);
        notifyListeners();
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBreakfastMeals() =>
      _firestoreApi.getFood(
          userId: currentUser.id!,
          date: _formattedDate,
          meal: mealTypeToString[MealType.breakfast]!);

  Stream<QuerySnapshot<Map<String, dynamic>>> getLunchMeals() =>
      _firestoreApi.getFood(
          userId: currentUser.id!,
          date: _formattedDate,
          meal: mealTypeToString[MealType.launch]!);

  Stream<QuerySnapshot<Map<String, dynamic>>> getDinnerMeals() =>
      _firestoreApi.getFood(
          userId: currentUser.id!,
          date: _formattedDate,
          meal: mealTypeToString[MealType.dinner]!);

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnacks() =>
      _firestoreApi.getFood(
          userId: currentUser.id!,
          date: _formattedDate,
          meal: mealTypeToString[MealType.snacks]!);

  Stream<QuerySnapshot<Map<String, dynamic>>> getExercises() =>
      _firestoreApi.getFood(
          userId: currentUser.id!, date: _formattedDate, meal: 'exercises');

  Stream<QuerySnapshot<Map<String, dynamic>>> getWater() => _firestoreApi
      .getFood(userId: currentUser.id!, date: _formattedDate, meal: 'water');

  void _getTheFoodConsumedInSpecificDay() {
    getBreakfastMeals();
    getLunchMeals();
    getDinnerMeals();
    getSnacks();
    getExercises();
    getWater();
  }

  void navigateToAddFood({required MealType mealType}) {
    _navigationService.navigateTo(Routes.addFoodView,
        arguments: AddFoodArgument(mealType: mealType, date: _formattedDate));
  }
}