import '../enums/food_type.dart';
import '../enums/meal_type.dart';

class AddFoodArgument {
  final FoodType foodType;
  final MealType mealType;
  final String? selectedFood;
  
  AddFoodArgument(
      {required this.foodType,
      required this.mealType,
      this.selectedFood,
      });
}