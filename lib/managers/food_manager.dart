import 'package:provider/provider.dart';
import 'package:z_fitness/api/firestore_api.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/models/food_models/food_details.dart';
import 'package:z_fitness/services/database_service.dart';

class FoodManager {
  // final _databaseService = locator<DatabaseService>();
  // final _foodApi = locator<FoodApi>();

  // Future getFoodDetails({required String foodId}) async {
  //   NutritientsDetail? _nutritionDetails;

  //   final _detailsResult = await _databaseService.getFoodFromDatabase(foodId);

  //   bool _foodExistInDatabase = _detailsResult != null;

  //   if (_foodExistInDatabase) {
  //     _nutritionDetails = _detailsResult.nutritientsDetail;
  //   } else {
  //     _foodApi.g
  //   }
  // }

  // Future getRecipeDetails({required String recipeId}) async {}
}
