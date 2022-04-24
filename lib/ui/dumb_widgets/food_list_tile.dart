import 'package:flutter/material.dart';
import 'package:z_fitness/enums/food_type.dart';

import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';

class FoodListTile extends StatelessWidget {
  final FoodConsumed food;

  const FoodListTile({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (foodTypeToString[food.foodType] == foodTypeToString[FoodType.recipe]) {
      // recipe
      return Container(
         margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
      color: kcBackgroundColor,

            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
            contentPadding: const EdgeInsets.all(0),

          title: Text(food.recipeDetails!.title ?? ''),
          subtitle: Text(food.recipeDetails!.servings.toString() + ' servings'),
          trailing: Text(food.calories!.round().toString(),style: const TextStyle(color: Colors.black54)),
        ),
      );
    }

    // branded or common food
    final _foodDetail = food.nutritientsDetail!.foods![0];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
      color: kcBackgroundColor,

            borderRadius: BorderRadius.all(Radius.circular(8))),
      
      child: ListTile(
            contentPadding: const EdgeInsets.all(0),

        title: Text(_foodDetail!.foodName ?? ''),
        subtitle: Text(
          _foodDetail.servingQty.toString() + ' ' + _foodDetail.servingUnit!,
        ),
        trailing: Text(food.calories!.round().toString(),style: const TextStyle(color: Colors.black54)),
      ),
    );
  }
}
