// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/managers/food_manager.dart';
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
  final _foodManager = locator<FoodManager>();

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

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 120),
        lastDate: DateTime(DateTime.now().year + 120));

    if (newDate == null) return;

    _formattedDate = DateFormat('dd-MM-yyyy').format(newDate);

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

  void onFoodLongPressed(FoodConsumed foodConsumed) async {
    final response = await _dialogService.showConfirmationDialog(
        confirmationTitle: 'Delete');
    if (response!.confirmed) {
      await _foodManager.deleteFoodFromDiary(foodConsumed);
    }
  }

  void onFoodPressed(FoodConsumed foodConsumed) {
    if (foodTypeToString[foodConsumed.foodType] ==
        foodTypeToString[FoodType.recipe]) {
      _navigationService.navigateTo(Routes.recipeDetailsView,
          arguments: RecipeDetailsArgument(
              userIsEditingNutrition: true,
              date: _formattedDate,
              foodType: foodConsumed.foodType,
              mealType: foodConsumed.mealType,
              recipeId: foodConsumed.recipeDetails!.id!,
              recipeDetails: foodConsumed.recipeDetails));
    } else {
      _navigationService.navigateTo(Routes.foodDetailsView,
          arguments: FoodDetailsArgument(
              databaseId: foodConsumed.databaseId,
              userIsEditingNutrition: true,
              date: _formattedDate,
              foodType: foodConsumed.foodType!,
              mealType: foodConsumed.mealType!,
              selectedFoodId: foodConsumed.foodApiId,
              nutritientsDetail: foodConsumed.nutritientsDetail));
    }
  }

  void navigateToAddFood({required MealType mealType}) {
    _navigationService.navigateTo(Routes.addFoodView,
        arguments: AddFoodArgument(mealType: mealType, date: _formattedDate));
  }

  Stream<List<FoodConsumed>> getBreakfastMeals() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.breakfast]!, _formattedDate);

  Stream<List<FoodConsumed>> getLunchMeals() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.lunch]!, _formattedDate);

  Stream<List<FoodConsumed>> getDinnerMeals() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.dinner]!, _formattedDate);

  Stream<List<FoodConsumed>> getSnacks() =>
      _databaseService.getFoodConsumedForSpecificMeal(
          mealTypeToString[MealType.snacks]!, _formattedDate);

  Stream<List<FoodConsumed>> getExercises() => _databaseService
      .getFoodConsumedForSpecificMeal('exercise', _formattedDate);

  Stream<List<FoodConsumed>> getWater() =>
      _databaseService.getFoodConsumedForSpecificMeal('water', _formattedDate);

  Stream<int> getBreaktotalCalories() =>
      _databaseService.getFoodTotalCaloriesForOneMeal(
          mealTypeToString[MealType.breakfast]!, _formattedDate);

  Stream<int> getLunchtotalCalories() =>
      _databaseService.getFoodTotalCaloriesForOneMeal(
          mealTypeToString[MealType.lunch]!, _formattedDate);

  Stream<int> getDinnerTotalCalories() =>
      _databaseService.getFoodTotalCaloriesForOneMeal(
          mealTypeToString[MealType.dinner]!, _formattedDate);

  Stream<int> getSnacksTotalCalories() =>
      _databaseService.getFoodTotalCaloriesForOneMeal(
          mealTypeToString[MealType.snacks]!, _formattedDate);

  Stream<int> getExerciseTotalCalories() => _databaseService
      .getFoodTotalCaloriesForOneMeal('exercise', _formattedDate);

  Stream<int> getWaterTotal() =>
      _databaseService.getFoodTotalCaloriesForOneMeal('water', _formattedDate);

  void _getTheFoodConsumedInSpecificDay() {
    getBreakfastMeals();
    getLunchMeals();
    getDinnerMeals();
    getSnacks();
    getExercises();
    getWater();
    getBreaktotalCalories();
    getLunchtotalCalories();
    getDinnerTotalCalories();
    getSnacksTotalCalories();
  }
}
