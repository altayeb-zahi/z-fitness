// ignore_for_file: unused_import

import 'dart:async';
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
import 'package:z_fitness/services/diary_service.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';
import '../../../../../api/firestore_api.dart';
import '../../../../../app/locator.dart';
import '../../../../../models/user.dart';
import '../../../../../services/user_service.dart';
import '../../../app/logger.dart';

//TODO when upload recipe to firestore and navigate back the currentIndex shoud go back to 0

class DiaryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _dialogService = locator<DialogService>();

  final _foodManager = locator<FoodManager>();

  final _diaryService = locator<DiaryService>();

  String dateTitle = 'Today';

  DateTime _date = DateTime.now();

  String _formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  User get currentUser => locator<UserService>().currentUser!;

  Stream<List<FoodConsumed>> getBreakfastMeals() =>
      _diaryService.getBreakfastStream;

  Stream<List<FoodConsumed>> getLunchMeals() => _diaryService.getLunchStream;

  Stream<List<FoodConsumed>> getDinnerMeals() => _diaryService.getdinnerStream;

  Stream<List<FoodConsumed>> getSnacks() => _diaryService.getSnacksStream;

  Stream<int> getBreaktotalCalories() =>
      _diaryService.getBreakfastTotalCaloriesStream;

  Stream<int> getLunchtotalCalories() =>
      _diaryService.getLunchTotalCaloriesStream;

  Stream<int> getDinnerTotalCalories() =>
      _diaryService.getDinnerTotalCaloriesStream;

  Stream<int> getSnacksTotalCalories() =>
      _diaryService.getSnacksTotalCaloriesStream;

  void onModelReady() =>
      _diaryService.getFoodConsumedForSpecificDay(_formattedDate);

  void closeStreamsControllers() => _diaryService.closeStreamsControllers();

  void onFoodLongPressed(FoodConsumed foodConsumed) async {
    final response = await _dialogService.showConfirmationDialog(
        confirmationTitle: 'Delete');
    if (response!.confirmed) {
      await _foodManager.deleteFoodFromDiary(foodConsumed);
    }
  }

  void navigateToAddFood({required MealType mealType}) {
    _navigationService.navigateTo(Routes.addFoodView,
        arguments: AddFoodArgument(mealType: mealType, date: _formattedDate));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 120),
        lastDate: DateTime(DateTime.now().year + 120));

    if (newDate == null) return;

    _date = newDate;

    _formattedDate = DateFormat('dd-MM-yyyy').format(newDate);

    _setDateTitle();

    _diaryService.getFoodConsumedForSpecificDay(_formattedDate);
  }

  void onDateArrowPressed({bool isForoward = true}) {
    DateTime _newDate;

    if (isForoward) {
      _newDate = DateTime(_date.year, _date.month, _date.day + 1);
    } else {
      _newDate = DateTime(_date.year, _date.month, _date.day - 1);
    }

    _date = _newDate;
    _formattedDate = DateFormat('dd-MM-yyyy').format(_newDate);

    _setDateTitle();

    _diaryService.getFoodConsumedForSpecificDay(_formattedDate);
  }

  void _setDateTitle() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = _date;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      dateTitle = 'Today';
    } else if (aDate == yesterday) {
      dateTitle = 'Yesterday';
    } else if (aDate == tomorrow) {
      dateTitle = 'Tomorrow';
    } else {
      dateTitle = DateFormat('dd-MM-yyyy').format(_date);
    }
    notifyListeners();
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
}
