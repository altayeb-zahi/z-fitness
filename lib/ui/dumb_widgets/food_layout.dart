import 'package:flutter/material.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/ui/dumb_widgets/food_list_tile.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';
import '../shared/ui_helpers.dart';

class FoodLayout extends StatelessWidget {
  final String title;
  final String addButtonTitle;

  final void Function() onAddPressed;
  final void Function(FoodConsumed foodConsumed) onFoodPressed;
  final void Function(FoodConsumed foodConsumed) onFoodLongPressed;
  final Stream<List<FoodConsumed>> mealsConsumedStream;
  final Stream<int> mealTotalCaloriesStream;

  const FoodLayout(
      {Key? key,
      // this.onFoodPressed,
      // this.onFoodLongPressed,
      required this.title,
      this.addButtonTitle = 'ADD FOOD',
      required this.onAddPressed,
      required this.onFoodPressed,
      required this.onFoodLongPressed,
      required this.mealsConsumedStream,
      required this.mealTotalCaloriesStream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: theme.textTheme.headline3,
              ),
              Expanded(child: Container()),
              StreamBuilder<int>(
                stream: mealTotalCaloriesStream,
                builder: (context, snapshot) {
                  int _totalCaloires = 0;

                  if (snapshot.hasError) {
                    return Text(_totalCaloires.toString());
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    Text(_totalCaloires.toString());
                  }

                  if (snapshot.hasData) {
                    _totalCaloires = snapshot.data!;
                  }

                  return Text(_totalCaloires.toString(),
                      style: theme.textTheme.headline4);
                },
              )
            ],
          ),
          verticalSpaceRegular,
          StreamBuilder<List<FoodConsumed>>(
              stream: mealsConsumedStream,
              builder: (BuildContext context, snapshot) {
                // to add the id to the the foodConsumed
                List<FoodConsumed> foodConsumedList = [];

                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                if (snapshot.hasData) {
                  foodConsumedList = snapshot.data!;
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final FoodConsumed _food = foodConsumedList[index];
                    return GestureDetector(
                        onTap: () => onFoodPressed(_food),
                        onLongPress: () => onFoodLongPressed(_food),
                        child: FoodListTile(food: _food));
                  },
                );
              }),
          GestureDetector(
            onTap: onAddPressed,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  verticalSpaceSmall,
                  Text(
                    addButtonTitle,
                    style: theme.textTheme.headline3!.copyWith(
                        color: primaryColorLight,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                  const Icon(Icons.more_horiz)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
