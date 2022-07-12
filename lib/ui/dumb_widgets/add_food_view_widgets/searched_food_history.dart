import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
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
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (foodHistory.isNotEmpty)
          Text(
            'History',
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.secondary),
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
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  UniconsLine.history,
                  size: 60,
                  color: theme.colorScheme.secondary,
                ),
                verticalSpaceMedium,
                Text("No History",
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                verticalSpaceSmall,
                const Text("Yout History will appear here"),
              ],
            ),
          )
      ],
    );
  }
}
