import 'package:flutter/material.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';

import '../../../models/food_models/food_consumed.dart';
import '../../shared/ui_helpers.dart';
import '../food_list_tile.dart';

class SearchedFoodHistory extends StatelessWidget {
  final List<FoodConsumed> foodHistory;
  final void Function(FoodConsumed foodConsumed) onHistoryItemPressed;

  const SearchedFoodHistory(
      {Key? key, required this.foodHistory, required this.onHistoryItemPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return // history
        Container(
            color: scafoldBackgroundColorLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'History',
                  style: theme.textTheme.headline3,
                ),
                verticalSpaceRegular,
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: foodHistory.length,
                    itemBuilder: (context, index) {
                      final _food = foodHistory[index];
                      return GestureDetector(
                          onTap: () => onHistoryItemPressed(foodHistory[index]),
                          child: FoodListTile(food: _food));
                    }),
                if (foodHistory.isEmpty)
                  SizedBox(
                      height: screenHeightPercentage(context, percentage: 0.6),
                      child: const Center(
                        child: Text("No History Yet"),
                      ))
              ],
            ));
  }
}
