import 'package:z_fitness/models/food_details.dart';
import 'package:z_fitness/models/recipe_details.dart';

class FoodConsumed {
  String? id;
  String foodType;
  double calories;
  String foodConsumed;
  //TODO find better name for NutritientsDetail
  NutritientsDetail? nutritientsDetail;
  RecipeDetails? recipeDetails;

  FoodConsumed(
      {this.id,
      required this.foodType,
      required this.calories,
      required this.foodConsumed,
      this.nutritientsDetail,
      this.recipeDetails});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foodType': foodType,
      'calories': calories,
      'foodConsumed': foodConsumed,
      'nutritientsDetail': nutritientsDetail != null
          ? nutritientsDetailsToJson(nutritientsDetail!)
          : null,
      'recipeDetails': recipeDetails != null ? recipeDetails!.toJson : null,
    };
  }

  factory FoodConsumed.fromMap(Map<String, dynamic> map) {
    return FoodConsumed(
        id: map['id'],
        foodType: map['foodType'] ?? '',
        calories: map['calories'],
        foodConsumed: map['foodConsumed'] ?? '',
        nutritientsDetail: map['foodType'] == 'food'
            ? NutritientsDetail.fromJson(map['foodConsumed'])
            : null,
        recipeDetails: map['foodType'] == 'recipe'
            ? RecipeDetails.fromJson(map['foodConsumed'])
            : null);
  }
}
