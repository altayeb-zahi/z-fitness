import 'package:z_fitness/api/firestore_api.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/models/food_models/food_details.dart';
import 'package:z_fitness/services/database_service.dart';
import '../app/logger.dart';
import '../enums/food_type.dart';
import '../models/arguments_models.dart';
import '../services/user_service.dart';

class FoodManager {
  final _databaseService = locator<DatabaseService>();
  final _foodApi = locator<FoodApi>();
  final _firestoreApi = locator<FirestoreApi>();
  final _currentUser = locator<UserService>().currentUser;

  Future<void> addFoodToDiary(FoodConsumed foodConsumed) async {
    String firestoreId = await _firestoreApi.addFoodToDiary(
        userId: _currentUser!.id!,
        foodConsumed: foodConsumed,
        date: foodConsumed.date!,
        mealType: mealTypeToString[foodConsumed.mealType]!);

    foodConsumed.id = firestoreId;

    await _databaseService.addFoodToDiary(foodConsumed);

  }

  Future<void> updateFoodInDiary(FoodConsumed foodConsumed) async {
    await _firestoreApi.updateFoodInDiary(
        userId: _currentUser!.id!,
        foodConsumed: foodConsumed,
        date: foodConsumed.date!,
        mealType: mealTypeToString[foodConsumed.mealType]!);

    await _databaseService.updateFoodInDiary(foodConsumed);

  }

  Future<void> deleteFoodFromDiary(FoodConsumed foodConsumed) async {
    await _firestoreApi.deleteFoodFromDiary(
        userId: _currentUser!.id!,
        foodId: foodConsumed.id!,
        date: foodConsumed.date!,
        mealType: mealTypeToString[foodConsumed.mealType]!);

    await _databaseService.deleteFoodFromDiary(foodConsumed.databaseId!);

  }

  Future<NutritientsDetail?> getFoodNutritionDetails(
      {required FoodDetailsArgument foodDetailsArgument}) async {
    NutritientsDetail? _nutritionDetails;

    final _foodId = foodDetailsArgument.selectedFoodId;

   

    if (foodDetailsArgument.userIsEditingNutrition || foodDetailsArgument.userNavigatedFromHistory) {
      log.v('user is editing nutrion details or navigated from history');

      _nutritionDetails = foodDetailsArgument.nutritientsDetail;
    } else {
      log.v('fetching food details from local database first');

      final _detailsFromDatabase =
          await _databaseService.getFoodNutritionDetails(_foodId!);

      bool _foodisStoredInLocalDatabase = _detailsFromDatabase != null;

      if (_foodisStoredInLocalDatabase) {
        log.v('food details exist in local database');

        _nutritionDetails = _detailsFromDatabase.nutritientsDetail;
      } else {
        log.v(
            'food details does not exist in local database, fetching it from the api');

        _nutritionDetails = await _getFoodDetailsFromApi(foodDetailsArgument);

        if (_nutritionDetails != null) {
          log.v('add the fetched nutrition details from api to local database');

          await _storeFoodNutritionDetailsInLocalDatabase(
              _nutritionDetails, _foodId);
        }
      }
    }

    return _nutritionDetails;
  }


  Future _getFoodDetailsFromApi(FoodDetailsArgument foodDetailsArgument) async {
    switch (foodDetailsArgument.foodType) {
      case FoodType.brandedFood:
        return await _foodApi.getNutritionDetailsForBrandedFood(
            selectedFoodId: foodDetailsArgument.selectedFoodId!);
      case FoodType.commonFood:
        return await _foodApi.getNutritionDetailsForCommonFood(
            selectedFoodId: foodDetailsArgument.selectedFoodId!);
      default:
    }
  }

  Future<void> _storeFoodNutritionDetailsInLocalDatabase(
      NutritientsDetail nutritionDetails, String foodApiId) async {
    final _foodConsumed = FoodConsumed(
        foodApiId: foodApiId,
        foodConsumed: nutritientsDetailsToJson(
          nutritionDetails,
        ));

    _databaseService.addFoodToDatabase(_foodConsumed);
  }

  
  // /// Using the serving_weight parameter value from the alt_measure array,
  // /// you can derive the nutrients in each serving by dividing that serving weight by
  // /// the default returned serving weight of the food object, and multiplying by the full_nutrients array:
  // /// (foods.alt_measures.serving_weight / foods.serving_weight_grams) * full_nutrients
  // NutritientsDetail getUpdatedNutrientsDetails(
  //     DialogResponseData dialogResponseData, Food originalFoodValues) {
  //   var _originalFoodServingWeight = originalFoodValues.servingWeightGrams!;
  //   double _newNumberOfServings = dialogResponseData.numberOfServings!;
  //   double _currentNumberOfServings = originalFoodValues.servingQty!;
  //   double _alMeasuresServingWeight =
  //       dialogResponseData.servingWeight ?? _originalFoodServingWeight;

  //   double num = (_newNumberOfServings / _currentNumberOfServings) *
  //       (_alMeasuresServingWeight / _originalFoodServingWeight);

  //   NutritientsDetail _updatedNutrientsDetail = NutritientsDetail(foods: [
  //     Food(
  //         foodName: originalFoodValues.foodName,
  //         photo: originalFoodValues.photo,
  //         servingQty: _newNumberOfServings,
  //         servingUnit: dialogResponseData.servingUnit,
  //         servingWeightGrams: originalFoodValues.servingWeightGrams,
  //         nfCalories: originalFoodValues.nfCalories! * num,
  //         nfTotalFat: originalFoodValues.nfTotalFat! * num,
  //         nfSaturatedFat: originalFoodValues.nfSaturatedFat! * num,
  //         nfCholesterol: originalFoodValues.nfCholesterol! * num,
  //         nfSodium: originalFoodValues.nfSodium! * num,
  //         nfTotalCarbohydrate: originalFoodValues.nfTotalCarbohydrate! * num,
  //         nfDietaryFiber: originalFoodValues.nfDietaryFiber! * num,
  //         nfSugars: originalFoodValues.nfSugars! * num,
  //         nfProtein: originalFoodValues.nfProtein! * num,
  //         nfPotassium: originalFoodValues.nfPotassium! * num,
  //         nfP: originalFoodValues.nfP != null
  //             ? originalFoodValues.nfP! * num
  //             : null,
  //         // fullNutrients: _updatedFullNutrients,
  //         altMeasures: originalFoodValues.altMeasures)
  //   ]);

  //   return _updatedNutrientsDetail;
  // }

}
