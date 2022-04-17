import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/ui/dumb_widgets/food_list_tile.dart';
import '../../app/logger.dart';
import '../shared/ui_helpers.dart';
import '../views/diary/diary_view_model.dart';

class FoodLayout extends StatelessWidget {
  final String title;
  final String addButtonTitle;

  final void Function() onAddPressed;
  final void Function(FoodConsumed foodConsumed) onFoodPressed;
  final void Function(FoodConsumed foodConsumed) onFoodLongPressed;
  final Stream<List<FoodConsumed>> stream;

  const FoodLayout({
    Key? key,
    // this.onFoodPressed,
    // this.onFoodLongPressed,
    required this.title,
    this.addButtonTitle = 'add food',
    required this.onAddPressed,
    required this.onFoodPressed,
    required this.onFoodLongPressed,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.i('food layout is built for $title');

    return Column(
      children: [
        ListTile(
            title: Text(title),
            trailing:
                Consumer<DiaryViewModel>(builder: (context, model, child) {
              int _calories = 0;

              //TODO think about it first.. instead of all the if statment pass the calories value in the consturctor

              if (title == 'Breakfast') {
                _calories = model.caloriesDetails.totalBreakfastCalories;
              } else if (title == 'Lunch') {
                _calories = model.caloriesDetails.totalLunchCalories;
              } else if (title == 'Dinner') {
                _calories = model.caloriesDetails.totalDinnerCalories;
              } else if (title == 'Snacks') {
                _calories = model.caloriesDetails.totalSnacksCalories;
              } else if (title == 'Exercise') {
                _calories = model.caloriesDetails.totalCaloriesConsumed;
              } else if (title == 'Water') {
                _calories = model.caloriesDetails.totalWaterConsumed;
              }

              return Text(_calories.toString());
            })),
        StreamBuilder<List<FoodConsumed>>(
            stream: stream,
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
          child: Row(
            children: [
              verticalSpaceSmall,
              const Icon(Icons.add),
              Text(addButtonTitle)
            ],
          ),
        ),
      ],
    );
  }
}
