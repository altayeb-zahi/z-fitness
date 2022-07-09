import 'dart:async';

import 'package:z_fitness/services/database_service.dart';

import '../app/locator.dart';
import '../enums/meal_type.dart';
import '../models/food_models/food_consumed.dart';

class DiaryService {
  final _databaseService = locator<DatabaseService>();
  late String _date;

  final _addFoodController = StreamController<FoodConsumed>.broadcast();
  StreamSink<FoodConsumed> get addFoodToDiary => _addFoodController.sink;

  final _updateFoodController = StreamController<FoodConsumed>.broadcast();
  StreamSink<FoodConsumed> get updateFoodInDiary => _updateFoodController.sink;

  final _deleteFoodController = StreamController<FoodConsumed>.broadcast();
  StreamSink<FoodConsumed> get deleteFoodFromDiary =>
      _deleteFoodController.sink;

  // breakfast
  // Create a broadcast controller that allows this stream to be listened to multiple times.
  final _breakfastController = StreamController<List<FoodConsumed>>.broadcast();
  final _breakfastTotalCaloriesController = StreamController<int>.broadcast();

  // Input stream. We add our breakfast food to the stream using this variable.
  StreamSink<List<FoodConsumed>> get _breakfastSink =>
      _breakfastController.sink;
  StreamSink<int> get _breakfastTotalCaloriesSink =>
      _breakfastTotalCaloriesController.sink;

  // Output stream. This one will be used within our pages to display the users.
  Stream<List<FoodConsumed>> get getBreakfastStream =>
      _breakfastController.stream;
  Stream<int> get getBreakfastTotalCaloriesStream =>
      _breakfastTotalCaloriesController.stream;

  // lunch
  final _lunchController = StreamController<List<FoodConsumed>>.broadcast();
  final _lunchTotalCaloriesController = StreamController<int>.broadcast();

  StreamSink<List<FoodConsumed>> get _lunchSink => _lunchController.sink;
  StreamSink<int> get _lunchTotalCaloriesSink =>
      _lunchTotalCaloriesController.sink;

  Stream<List<FoodConsumed>> get getLunchStream => _lunchController.stream;
  Stream<int> get getLunchTotalCaloriesStream =>
      _lunchTotalCaloriesController.stream;

  // dinner
  final _dinnerController = StreamController<List<FoodConsumed>>.broadcast();
  final _dinnerTotalCaloriesController = StreamController<int>.broadcast();

  StreamSink<List<FoodConsumed>> get _dinnerSink => _dinnerController.sink;
  StreamSink<int> get _dinnerTotalCaloriesSink =>
      _dinnerTotalCaloriesController.sink;

  Stream<List<FoodConsumed>> get getdinnerStream => _dinnerController.stream;
  Stream<int> get getDinnerTotalCaloriesStream =>
      _dinnerTotalCaloriesController.stream;

  // snacks
  final _snacksController = StreamController<List<FoodConsumed>>.broadcast();
  final _snacksTotalCaloriesController = StreamController<int>.broadcast();

  StreamSink<List<FoodConsumed>> get _snacksSink => _snacksController.sink;
  StreamSink<int> get _snacksTotalCaloriesSink =>
      _snacksTotalCaloriesController.sink;

  Stream<List<FoodConsumed>> get getSnacksStream => _snacksController.stream;
  Stream<int> get getSnacksTotalCaloriesStream =>
      _snacksTotalCaloriesController.stream;

  // We'll call this from our page when page is initialize and when the date change.
  void getFoodConsumedForSpecificDay(String date) {
    _date = date;

    updateScreenData();

    _addFoodController.stream.listen(_handleAddFood);
    _updateFoodController.stream.listen(_handleUpdateFood);
    _deleteFoodController.stream.listen(_handleDeleteFood);
  }

  void _handleAddFood(FoodConsumed foodConsumed) async {
    await _databaseService.addFoodToDiary(foodConsumed);
    _refreshSpecificMealStream(foodConsumed.mealType!);
  }

  void _handleUpdateFood(FoodConsumed foodConsumed) async {
    await _databaseService.updateFoodInDiary(foodConsumed);
    _refreshSpecificMealStream(foodConsumed.mealType!);
  }

  void _handleDeleteFood(FoodConsumed foodConsumed) async {
    await _databaseService.deleteFoodFromDiary(foodConsumed.databaseId!);
    _refreshSpecificMealStream(foodConsumed.mealType!);
  }

  void updateScreenData() async {
    _updateBreakfastData();
    _updateLunchData();
    _updateDinnerData();
    _updateSnacksData();
  }

  void _updateBreakfastData() async {
    final _breakFast = await _databaseService.getFoodConsumedForSpecificDay(
        mealTypeToString[MealType.breakfast]!, _date);

    final _breakfastTotalCalories =
        await _databaseService.getFoodTotalCaloriesForOneMealTest(
            mealTypeToString[MealType.breakfast]!, _date);

    _breakfastSink.add(_breakFast);
    _breakfastTotalCaloriesSink.add(_breakfastTotalCalories);
  }

  void _updateLunchData() async {
    final _lunch = await _databaseService.getFoodConsumedForSpecificDay(
        mealTypeToString[MealType.lunch]!, _date);

    final _lunchTotalCalories =
        await _databaseService.getFoodTotalCaloriesForOneMealTest(
            mealTypeToString[MealType.lunch]!, _date);

    _lunchSink.add(_lunch);
    _lunchTotalCaloriesSink.add(_lunchTotalCalories);
  }

  void _updateDinnerData() async {
    final _dinner = await _databaseService.getFoodConsumedForSpecificDay(
        mealTypeToString[MealType.dinner]!, _date);

    final _dinnerTotalCalories =
        await _databaseService.getFoodTotalCaloriesForOneMealTest(
            mealTypeToString[MealType.dinner]!, _date);

    _dinnerSink.add(_dinner);
    _dinnerTotalCaloriesSink.add(_dinnerTotalCalories);
  }

  void _updateSnacksData() async {
    final _snacks = await _databaseService.getFoodConsumedForSpecificDay(
        mealTypeToString[MealType.snacks]!, _date);

    final _snacksTotalCalories =
        await _databaseService.getFoodTotalCaloriesForOneMealTest(
            mealTypeToString[MealType.snacks]!, _date);

    _snacksSink.add(_snacks);
    _snacksTotalCaloriesSink.add(_snacksTotalCalories);
  }

  void _refreshSpecificMealStream(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        _updateBreakfastData();
        break;
      case MealType.lunch:
        _updateLunchData();
        break;

      case MealType.dinner:
        _updateDinnerData();
        break;

      case MealType.snacks:
        _updateSnacksData();
        break;
      default:
    }
  }
}
