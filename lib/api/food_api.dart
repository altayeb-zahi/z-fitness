import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app/logger.dart';
import '../constants/http_constants.dart';
import '../enums/food_type.dart';
import '../models/arguments_models.dart';
import '../models/food_details.dart';
import '../models/food_search.dart';

class FoodApi {
  Future getSearchedFood({required String searchText}) async {
    try {
      log.i('FoodApi - getSearchedFood');

      var _response = await http.get(
          Uri.parse(foodSearchEndPoint + 'query=$searchText'),
          headers: foodHeaders);
      if (_response.statusCode == 200) {
        SearchedFood searchedFood =
            SearchedFood.fromJson(json.decode(_response.body));

        log.v('successfully fetched search result for $searchText');

        return searchedFood;
      }

      log.e('failed to fetch searched food result');
      return 'Failed to get search result';
    } on SocketException catch (e) {
      log.e(' socket exeption' + e.toString());
    }
  }

  Future getFoodNutritionDetails(
      {required AddFoodArgument addFoodArgument, String? timeZone}) async {
    log.i('FoodApi - getFoodNutritionDetails');

    switch (addFoodArgument.foodType) {
      case FoodType.common:
        return _getNutritionDetailsFromNaturalNutrientsEndpoint(
            addFoodArgument.selectedFood, timeZone);

      case FoodType.branded:
        return _getNutritionDetailsFromSearchItemEndpoint(
            addFoodArgument.selectedFood);
    }
  }

  Future _getNutritionDetailsFromNaturalNutrientsEndpoint(
      String? selectedFood, String? timeZone) async {
    var _response = await http.post(Uri.parse(naturalNutrientsEndPoint),
        headers: foodHeaders,
        body: {'query': selectedFood, "timezone": timeZone});
    if (_response.statusCode == 200) {
      NutritientsDetail foodNutritionDetail =
          NutritientsDetail.fromJson(json.decode(_response.body));

      final _foodDetails = foodNutritionDetail.foods![0]!;

      foodNutritionDetail.foods![0]!.foodType = FoodTypeString[FoodType.common];

      log.v('successfully fetched nutrition details for ' +
          _foodDetails.foodName.toString() +
          ' type:common');

      return foodNutritionDetail;
    }
    log.e('Failed to get  food nutrition details,  type:common');
    return 'Failed to get  food nutrition details';
  }

  Future _getNutritionDetailsFromSearchItemEndpoint(
      String? selectedFood) async {
    var response = await http.get(
        Uri.parse(searchItemEndPoint + 'nix_item_id=$selectedFood'),
        headers: foodHeaders);
    if (response.statusCode == 200) {
      NutritientsDetail foodNutritionDetail =
          NutritientsDetail.fromJson(json.decode(response.body));

      final _foodDetails = foodNutritionDetail.foods![0]!;

      _foodDetails.foodType = FoodTypeString[FoodType.branded];

      log.v('successfully fetched nutrition details for ' +
          _foodDetails.foodName.toString() +
          ' type:branded');

      return foodNutritionDetail;
    }

    log.e('Failed to get  food nutrition details,  type:branded');
    return 'Failed to get  food nutrition details';
  }

  // Future getExerciseEstimatedCalories(String searchText) async {
  //   var gender = 'female';
  //   var weightKg = 72.5;
  //   var heightCm = 167.64;
  //   var age = 30;
  //   var _response = await http
  //       .post(Uri.parse(exerciseEndPoint), headers: exerciseHeaders, body: {
  //     'query': searchText,
  //     "gender": gender,
  //     "weight_kg": weightKg,
  //     "height_cm": heightCm,
  //     "age": age
  //   });
  //   if (_response.statusCode == 200) {
  //     ExcerciseModel exerciseDetail =
  //         ExcerciseModel.fromJson(json.decode(_response.body));
  //     return exerciseDetail;
  //   }
  //   return 'couldnt get the excercise details ';
  // }
}
