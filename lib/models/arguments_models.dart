import 'package:z_fitness/models/food_models/food_details.dart';
import 'package:z_fitness/models/recipes_models/recipe_details.dart';

import '../enums/food_type.dart';
import '../enums/meal_type.dart';

class AddFoodArgument {
  MealType mealType;
  String date;
  AddFoodArgument({
    required this.mealType,
    required this.date,
  });
}

class FoodDetailsArgument {
  final String date;

  final FoodType foodType;

  /// to know where to add the food, for example to breakfast or dinner or...
  final MealType mealType;

  /// use the id to get the nutrition details when user taps on the food from addFoodView search
  final String? selectedFoodId;

  /// store the food nutrition details when user tap on the food from diaryView or from the history in addFoodView
  NutritientsDetail? nutritientsDetail;

  int? databaseId;

  bool userIsEditingNutrition;
  bool userNavigatedFromHistory;

  FoodDetailsArgument(
      {required this.date,
      required this.foodType,
      required this.mealType,
      this.selectedFoodId,
      this.nutritientsDetail,
      this.databaseId,
      this.userIsEditingNutrition = false,
      this.userNavigatedFromHistory = false});
}

class RecipeDetailsArgument {
  final String? date;

  final FoodType? foodType;

  final MealType? mealType;

  final int recipeId;

  bool userIsEditingNutrition;
  bool userNavigatedFromHistory;

  /// store the food nutrition details when user tap on the food from diaryView or from the history in addFoodView
  RecipeDetails? recipeDetails;
  RecipeDetailsArgument(
      {this.date,
      this.foodType,
      this.mealType,
      required this.recipeId,
      this.recipeDetails,
      this.userIsEditingNutrition = false,
      this.userNavigatedFromHistory = false});
}
