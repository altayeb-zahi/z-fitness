import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/models/food_models/food_details.dart';
import 'package:z_fitness/models/recipes_models/recipe_details.dart';
import 'package:z_fitness/utils/helpers.dart';

class FoodConsumed {
  bool forDatabase;
  // firestore id
  String? id;

  int? databaseId;

  // food and recipe api id i will use for database history by checking if this id exist there or no then decide to add new history or no
  String? foodApiId;
  int? recipeApiId;
  FoodType foodType;
  MealType mealType;
  double calories;
  String foodConsumed;

  bool isStoredLocally;
  //TODO find better name for NutritientsDetail
  NutritientsDetail? nutritientsDetail;
  RecipeDetails? recipeDetails;

  FoodConsumed(
      {
        this.forDatabase = false,
        this.id,
      this.databaseId,
      this.foodApiId,
      this.recipeApiId,
      required this.foodType,
      required this.mealType,
      required this.calories,
      required this.foodConsumed,
      this.isStoredLocally = false,
      this.nutritientsDetail,
      this.recipeDetails});

  Map<String, dynamic> toMap() {
    if(forDatabase){
      return  {
        'databaseId': databaseId,
      'foodApiId': foodApiId,
      'recipeApiId': recipeApiId,
      'foodType': foodTypeToString[foodType],
      'mealType': mealTypeToString[mealType],
      'calories': calories,
      'foodConsumed': foodConsumed,
      'nutritientsDetail': nutritientsDetail != null
          ? nutritientsDetailsToJson(nutritientsDetail!)
          : null,
      'recipeDetails': recipeDetails != null ? recipeDetails!.toJson : null,
    };
    }
    return {
      'id': id,
      'foodApiId': foodApiId,
      'recipeApiId': recipeApiId,
      'foodType': foodTypeToString[foodType],
      'mealType': mealTypeToString[mealType],
      'calories': calories,
      'foodConsumed': foodConsumed,
      'isStoredLocally': isStoredLocally,
      'nutritientsDetail': nutritientsDetail != null
          ? nutritientsDetailsToJson(nutritientsDetail!)
          : null,
      'recipeDetails': recipeDetails != null ? recipeDetails!.toJson : null,
    };
  }

  factory FoodConsumed.fromMap(Map<String, dynamic> map) {
    return FoodConsumed(
        id: map['id'],
        databaseId: map['databaseId'],
        foodApiId: map['foodApiId'],
        recipeApiId: map['recipeApiId'],
        foodType: convertStringToEnum(FoodType.values, map['foodType']),
        mealType: convertStringToEnum(MealType.values, map['mealType']),
        calories: map['calories'],
        foodConsumed: map['foodConsumed'],
        isStoredLocally: map['isStoredLocally'] ?? true,
        nutritientsDetail:
            map['foodType'] == foodTypeToString[FoodType.brandedFood] ||
                    map['foodType'] == foodTypeToString[FoodType.commonFood]
                ? nutritientsDetailsFromJson(map['foodConsumed'])
                : null,
        recipeDetails: map['foodType'] == foodTypeToString[FoodType.recipe]
            ? RecipeDetails.fromJson(map['foodConsumed'])
            : null);
  }
}
