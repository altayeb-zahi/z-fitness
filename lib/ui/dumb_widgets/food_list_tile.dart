import 'package:flutter/material.dart';
import 'package:z_fitness/enums/food_type.dart';

import 'package:z_fitness/models/food_models/food_consumed.dart';

class FoodListTile extends StatelessWidget {
  final FoodConsumed food;

  const FoodListTile({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (food.foodType == foodTypeToString[FoodType.recipe]) {
      // recipe
      return ListTile(
        title: Text(food.recipeDetails!.title ?? ''),
        subtitle: Text(food.recipeDetails!.servings.toString() + ' servings'),
        trailing: Text(food.calories.round().toString()),
      );
    }

    // branded or common food
    final _foodDetail = food.nutritientsDetail!.foods![0];
    return ListTile(
      title: Text(_foodDetail!.foodName ?? ''),
      subtitle: Text(
        _foodDetail.servingQty.toString() + ' ' + _foodDetail.servingUnit!,
      ),
      trailing: Text(food.calories.round().toString()),
    );
  }
}
