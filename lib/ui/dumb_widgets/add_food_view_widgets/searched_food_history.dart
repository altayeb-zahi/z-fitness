import 'package:flutter/material.dart';

import '../../../models/food_models/food_consumed.dart';
import '../../shared/ui_helpers.dart';
import '../food_list_tile.dart';

class SearchedFoodHistory extends StatelessWidget {
  final List<FoodConsumed> foodHistory;

  const SearchedFoodHistory({
    Key? key,
    required this.foodHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // history
        Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('History'),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: foodHistory.length,
                    itemBuilder: (context, index) {
                      final _food = foodHistory[index];
                      return FoodListTile(food: _food);
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
