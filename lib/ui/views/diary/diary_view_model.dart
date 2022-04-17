// ignore_for_file: unused_import

import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/calories_details.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/services/calories_service.dart';
import 'package:z_fitness/services/database_service.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';
import '../../../../../api/firestore_api.dart';
import '../../../../../app/locator.dart';
import '../../../../../models/user.dart';
import '../../../../../services/user_service.dart';
import '../../../app/logger.dart';

//TODO when upload recipe to firestore and navigate back the currentIndex shoud go back to 0

class DiaryViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _caloresService = locator<CaloriesService>();
  final _databaseService = locator<DatabaseService>();

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
        final _caloriesDetailsResult =
            CaloriesDetails.fromMap(calories.data()!);

        _caloresService.setCaloriesDetails(_caloriesDetailsResult);
        _caloriesDetails = _caloriesDetailsResult;

        notifyListeners();
      }
    });
  }

  void _deleteFood(FoodConsumed foodConsumed) async {
    await _firestoreApi.deleteFood(
        userId: currentUser.id!,
        foodId: foodConsumed.id!,
        date: _formattedDate,
        mealType: mealTypeToString[foodConsumed.mealType]!);

    //TODO handle the exemption
  }

  void onFoodLongPressed(FoodConsumed foodConsumed) async {
    final response = await _dialogService.showConfirmationDialog(
        confirmationTitle: 'Delete');
    if (response!.confirmed) _deleteFood(foodConsumed);
  }

  void onFoodPressed(FoodConsumed foodConsumed) {
    if (foodTypeToString[foodConsumed.foodType] ==
        foodTypeToString[FoodType.recipe]) {
      _navigationService.navigateTo(Routes.recipeDetailsView,
          arguments: RecipeDetailsArgument(
              userIsEditingRecipeDetails: true,
              date: _formattedDate,
              foodType: foodConsumed.foodType,
              mealType: foodConsumed.mealType,
              recipeId: foodConsumed.recipeDetails!.id!,
              recipeDetails: foodConsumed.recipeDetails));
    } else {
      _navigationService.navigateTo(Routes.foodDetailsView,
          arguments: FoodDetailsArgument(
              userIsEditingFoodDetails: true,
              date: _formattedDate,
              foodType: foodConsumed.foodType,
              mealType: foodConsumed.mealType,
              selectedFoodId: foodConsumed.foodApiId));
    }
  }

  void navigateToAddFood({required MealType mealType}) {
    _navigationService.navigateTo(Routes.addFoodView,
        arguments: AddFoodArgument(mealType: mealType, date: _formattedDate));
  }

  Stream<List<FoodConsumed>> getBreakfastMeals() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.breakfast]!);

  Stream<List<FoodConsumed>> getLunchMeals() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.lunch]!);

  Stream<List<FoodConsumed>> getDinnerMeals() =>
     _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.dinner]!);

  Stream<List<FoodConsumed>> getSnacks() =>
     _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.snacks]!);

 Stream<List<FoodConsumed>> getExercises() =>
     _databaseService.getFoodConsumedForSpecificMeal(
          'exercise');

  Stream<List<FoodConsumed>> getWater() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          'water');

  void _getTheFoodConsumedInSpecificDay() {
    getBreakfastMeals();
    getLunchMeals();
    getDinnerMeals();
    getSnacks();
    getExercises();
    getWater();
  }
}
