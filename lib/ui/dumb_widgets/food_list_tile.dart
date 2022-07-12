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
    final theme = Theme.of(context);
    if (foodTypeToString[food.foodType] == foodTypeToString[FoodType.recipe]) {
      // recipe
      return Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: theme.colorScheme.surfaceVariant.withOpacity(1)),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(food.recipeDetails!.title ?? ''),
          subtitle: Text(food.recipeDetails!.servings.toString() + ' servings'),
          trailing: Text(
            food.calories!.round().toString(),
            style: theme.textTheme.caption,
          ),
        ),
      );
    }

    // branded or common food
    final _foodDetail = food.nutritientsDetail!.foods![0];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: theme.colorScheme.surfaceVariant.withOpacity(0.3)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(_foodDetail!.foodName ?? ''),
        subtitle: Text(
          _foodDetail.servingQty.toString() + ' ' + _foodDetail.servingUnit!,
        ),
        trailing: Text(
          food.calories!.round().toString(),
          style: theme.textTheme.caption,
        ),
      ),
    );
  }
}
