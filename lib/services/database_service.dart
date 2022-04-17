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
      await _database!.execute('''
CREATE TABLE food(
   databaseId INTEGER PRIMARY KEY,
   foodApiId TEXT,
   recipeApiId INTEGER,
   foodType TEXT,
   foodConsumed TEXT
)''');


// stores the food and recipes that user add it to diary
      await _database!.execute('''
CREATE TABLE foodConsumed(
   databaseId INTEGER PRIMARY KEY,
   foodApiId TEXT,
   recipeApiId INTEGER,
   mealType TEXT,
   foodType TEXT,
   calories REAL,
   foodConsumed TEXT
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

  Future updateFoodInDatabase(FoodConsumed food) async {
    log.i('DatabaseService - updateFoodInDatabase');

    try {
      await _database!.update(foodTableName, food.toMap(),
          where: 'id = ?', whereArgs: [food.id]);
      log.v('food in database updated successfully');
    } catch (e) {
      return 'couldnt update Food in database $e';
    }
  }

  Future deleteFoodFromDatabase(int foodId) async {
    log.i('DatabaseService - deleteFoodFromDatabase');

    try {
      await _database!
          .delete(foodTableName, where: 'id = ?', whereArgs: [foodId]);
      log.v('food in database is deleted successfully');
    } catch (e) {
      return 'couldnt delete Food from database $e';
    }
  }

  Future<List<FoodConsumed>?> getFoodHistoryFromDatabase() async {
    log.i('DatabaseService - getFoodHistory');

    List<Map> _foodsResult =
        await _database!.query(foodTableName, limit: 10, orderBy: ' "id" DESC');

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

  Future<FoodConsumed?> getFoodFromDatabase(String foodId) async {
    log.i('DatabaseService - getFoodFromDatabase');

    List<Map> _result = await _database!
        .query(foodTableName, where: '"foodApiId" = ?', whereArgs: [foodId]);

    if (_result.isEmpty) {
      log.v('food doesnt exist in database');

      return null;
    }

    log.v('fetched food from database successfully');

    return FoodConsumed.fromMap(_result.first as Map<String, dynamic>);
    ;
  }

  Future<FoodConsumed?> getRecipeFromDatabase(int recipeId) async {
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

  Stream<List<FoodConsumed>> getFoodConsumedForSpecificMeal(String mealType) {
    log.i('DatabaseService - getFoodConsumedForSpecificMeal');

    final Stream<List<FoodConsumed>> _foodConsumedResult =
        _briteDatabase!.createQuery(
      foodTableName,
      where: 'mealType LIKE ?',
      whereArgs: [mealType],
    ).mapToList((row) => FoodConsumed.fromMap(row));

    return _foodConsumedResult;
  }
}
