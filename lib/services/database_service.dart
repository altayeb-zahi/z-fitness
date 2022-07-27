import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import '../app/logger.dart';
import '../constants/database_constants.dart';

class DatabaseService {
  Database? _database;

  Future initialise() async {
    if (_database == null) {
      log.i('DatabaseService - initialise');

      _database = await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'fittness_database.db'),
      );

// stores food and recipes when user search it, it doesnt matter if user add it to the diary or no
// the goal is next time user needs nutrion details no need to call the api and fetch it from databse
      await _database!.execute('''CREATE TABLE IF NOT EXISTS  food(
   id TEXT,     
   databaseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   foodApiId TEXT,
   recipeApiId INTEGER,
   mealType TEXT,
   foodType TEXT,
   calories REAL,
   foodConsumed TEXT,
   date TEXT,
   nutritientsDetail TEXT,
   recipeDetails TEXT
)''');

// stores the food and recipes that user add it to diary
      await _database!.execute('''
CREATE TABLE IF NOT EXISTS foodConsumed(
   id TEXT,
   databaseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   foodApiId TEXT,
   recipeApiId INTEGER,
   mealType TEXT,
   foodType TEXT,
   calories REAL,
   foodConsumed TEXT,
   date TEXT,
   nutritientsDetail TEXT,
   recipeDetails TEXT
)''');
    }
  }

  Future addFoodToDatabase(FoodConsumed food) async {
    log.i('DatabaseService - addFoodToDatabase');

    try {
      await _database!.insert(foodTableName, food.toMap());
      log.v('food added to database successfully');
    } catch (e) {
      return 'coulnt add Food to database $e';
    }
  }

  Future addFoodToDiary(FoodConsumed food) async {
    log.i('DatabaseService - addFoodToDatabase');

    try {
      await _database!.insert(foodConsumedTableName, food.toMap());
      log.v('food added to database successfully');
    } catch (e) {
      return 'coulnt add Food to database $e';
    }
  }

  Future updateFoodInDiary(FoodConsumed food) async {
    log.i('DatabaseService - updateFoodInDiary');

    try {
      await _database!.update(foodConsumedTableName, food.toMap(),
          where: 'databaseId = ?', whereArgs: [food.databaseId]);
      log.v('food in database updated successfully');
    } catch (e) {
      return 'couldnt update Food in database $e';
    }
  }

  Future deleteFoodFromDiary(int foodId) async {
    log.i('DatabaseService - deleteFoodFromDatabase');

    try {
      await _database!.delete(foodConsumedTableName,
          where: 'databaseId = ?', whereArgs: [foodId]);
      log.v('food in database is deleted successfully');
    } catch (e) {
      return 'couldnt delete Food from database $e';
    }
  }

  Future<List<FoodConsumed>?> getFoodHistoryFromDatabase() async {
    log.i('DatabaseService - getFoodHistory');

    List<Map> _foodsResult = await _database!
        .query(foodConsumedTableName, limit: 10, orderBy: ' "id" DESC');

    if (_foodsResult.isEmpty) {
      log.v('no history in database yet');
      return null;
    }

    List<FoodConsumed> _foods = _foodsResult
        .map((food) => FoodConsumed.fromMap(food as Map<String, dynamic>))
        .toList();

    log.v('fetched history from database successfully');

    return _foods;
  }

  Future<FoodConsumed?> getFoodNutritionDetails(String foodId) async {
    log.i('DatabaseService - getFoodFromDatabase');

    List<Map> _result = await _database!
        .query(foodTableName, where: '"foodApiId" = ?', whereArgs: [foodId]);

    if (_result.isEmpty) {
      log.v('food doesnt exist in database');

      return null;
    }

    log.v('fetched food from database successfully');

    return FoodConsumed.fromMap(_result.first as Map<String, dynamic>);
  }

  Future<FoodConsumed?> getRecipeNutritionDetails(int recipeId) async {
    log.i('DatabaseService - getRecipeFromDatabase');

    List<Map> _result = await _database!.query(foodTableName,
        where: '"recipeApiId" = ?', whereArgs: [recipeId]);

    if (_result.isEmpty) {
      log.v('recipe doesnt exist in database');

      return null;
    }

    log.v('fetched recipe from database successfully');

    return FoodConsumed.fromMap(_result.first as Map<String, dynamic>);
  }

  Future<List<FoodConsumed>> getFoodConsumedForSpecificDay(
      String mealType, String date) async {
    log.i('DatabaseService - getFoodConsumedForSpecificMeal');

    final List<Map> _foodsResult = await _database!.query(
      foodConsumedTableName,
      where: '"mealType" =? and "date" =?',
      whereArgs: [mealType, date],
    );

    if (_foodsResult.isEmpty) {
      return [];
    }

    List<FoodConsumed> _foods = _foodsResult
        .map((food) => FoodConsumed.fromMap(food as Map<String, dynamic>))
        .toList();

    return _foods;
  }

  Future<int> getFoodTotalCaloriesForOneMealTest(
      String mealType, String date) async {
    final mealCaloriesResult = await _database!.rawQuery(
        'SELECT SUM(calories) FROM $foodConsumedTableName  WHERE "mealType" =? and "date" =?',
        [mealType, date]);

    final mealTotalCalories = mealCaloriesResult.first.values.first;
    if (mealTotalCalories == null) return 0;

    mealTotalCalories as double;
    return mealTotalCalories.round();
  }
}
