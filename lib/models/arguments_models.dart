import 'package:z_fitness/models/food_details.dart';

import '../enums/food_type.dart';
import '../enums/meal_type.dart';

class FoodDetailsArgument {
  final String date;

  final FoodType foodType;

  /// to know where to add the food, for example to breakfast or dinner or...
  final MealType mealType;

  /// use the id to get the nutrition details when user taps on the food from addFoodView search
  final String? selectedFoodId;

  /// store the food nutrition details when user tap on the food from diaryView or from the history in addFoodView
  NutritientsDetail? nutritientsDetail;


  FoodDetailsArgument(
      {required this.date,
      required this.foodType,
      required this.mealType,
      this.selectedFoodId,
      this.nutritientsDetail,
      });
}
