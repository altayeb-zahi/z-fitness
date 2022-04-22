import 'package:sqlbrite/sqlbrite.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import '../app/logger.dart';
import '../constants/database_constants.dart';

class DatabaseService {
  Database? _database;
  BriteDatabase? _briteDatabase;

  Future initialise() async {
    if (_database == null) {
      log.i('DatabaseService - initialise');

      _database = await openDatabase(databaseName, version: 1);
      _briteDatabase = BriteDatabase(_database!, logger: null);

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
      await _briteDatabase!.insert(foodTableName, food.toMap());
      log.v('food added to database successfully');
    } catch (e) {
      return 'coulnt add Food to database $e';
    }
  }

  Future addFoodToDiary(FoodConsumed food) async {
    log.i('DatabaseService - addFoodToDatabase');

    try {
      await _briteDatabase!.insert(foodConsumedTableName, food.toMap());
      log.v('food added to database successfully');
    } catch (e) {
      return 'coulnt add Food to database $e';
    }
  }

  Future updateFoodInDiary(FoodConsumed food) async {
    log.i('DatabaseService - updateFoodInDiary');

    try {
      await _briteDatabase!.update(foodConsumedTableName, food.toMap(),
          where: 'databaseId = ?', whereArgs: [food.databaseId]);
      log.v('food in database updated successfully');
      log.i(food.databaseId);
    } catch (e) {
      return 'couldnt update Food in database $e';
    }
  }

  Future deleteFoodFromDiary(int foodId) async {
    log.i('DatabaseService - deleteFoodFromDatabase');

    try {
      await _briteDatabase!.delete(foodConsumedTableName,
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

  Stream<List<FoodConsumed>> getFoodConsumedForSpecificMeal(
      String mealType, String date) {
    log.i('DatabaseService - getFoodConsumedForSpecificMeal');

    final Stream<List<FoodConsumed>> _foodConsumedResult =
        _briteDatabase!.createQuery(
      foodConsumedTableName,
      where: 'mealType IN (?,?)',
      whereArgs: [mealType, date],
    ).mapToList((row) => FoodConsumed.fromMap(row));

    return _foodConsumedResult;
  }

  Stream<int> getFoodTotalCaloriesForOneMeal(String mealType, String date) {
    log.i(
        'DatabaseService - getFoodConsumedForSpecificMeal for $mealType on $date');

    return _briteDatabase!
        .createRawQuery(
            [foodConsumedTableName],
            'SELECT SUM(calories) FROM $foodConsumedTableName  WHERE "mealType" =? and "date" =?',
            [mealType, date])
        .mapToOne((row) {
      if (row.values.first == null) return 0;
      var calories = row.values.first as double;
      return calories.round();
    });
  }
}
