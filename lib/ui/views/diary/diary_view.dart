import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';
import 'diary_view_model.dart';
import '../../dumb_widgets/calories_counter_layout.dart';
import '../../dumb_widgets/food_layout.dart';
import '../../shared/ui_helpers.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({Key? key}) : super(key: key);

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  final model = DiaryViewModel();

  @override
  void initState() {
    model.onModelReady();
    super.initState();
  }

  @override
  void dispose() {
    model.closeStreamsControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.keyboard_arrow_left,
              color: primaryColorLight,
            ),
            Expanded(child: Container()),
            GestureDetector(
                onTap: () => model.pickDate(context),
                child: const Text('Today')),
            Expanded(child: Container()),
            const Icon(
              Icons.keyboard_arrow_right,
              color: primaryColorLight,
            )
          ],
        ),
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                _caloriesRemaining(),
                divider,
                verticalSpaceRegular,
                _breakfast(),
                divider,
                _lunch(),
                divider,
                _dinner(),
                divider,
                _snaks(),
                // divider,
                // _exercises(),
                // divider,
                // _water(),
                // divider
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _caloriesRemaining() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
        child: Consumer<DiaryViewModel>(
          builder: (context, model, child) => const CaloriesCounterLayout(),
        ),
      );

  Widget _breakfast() => FoodLayout(
        title: 'Breakfast',
        mealsConsumedStream: model.getBreakfastMeals(),
        mealTotalCaloriesStream: model.getBreaktotalCalories(),
        onAddPressed: () =>
            model.navigateToAddFood(mealType: MealType.breakfast),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _lunch() => FoodLayout(
        title: 'Lunch',
        mealsConsumedStream: model.getLunchMeals(),
        mealTotalCaloriesStream: model.getLunchtotalCalories(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.lunch),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _dinner() => FoodLayout(
        title: 'Dinner',
        mealsConsumedStream: model.getDinnerMeals(),
        mealTotalCaloriesStream: model.getDinnerTotalCalories(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.dinner),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _snaks() => FoodLayout(
        title: 'Snacks',
        mealsConsumedStream: model.getSnacks(),
        mealTotalCaloriesStream: model.getSnacksTotalCalories(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.snacks),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  // Widget _exercises() => FoodLayout(
  //       title: 'Exercise',
  //       addButtonTitle: 'add exercise',
  //       mealTotalCaloriesStream: model.getExerciseTotalCalories(),
  //       mealsConsumedStream: model.getExercises(),
  //       onAddPressed: () {},
  //       onFoodLongPressed: (foodConsumed) {},
  //       onFoodPressed: (foodConsumed) {},
  //     );

  // Widget _water() => FoodLayout(
  //       title: 'Water',
  //       addButtonTitle: 'add water',
  //       mealTotalCaloriesStream: model.getWaterTotal(),
  //       mealsConsumedStream: model.getWater(),
  //       onAddPressed: () {},
  //       onFoodLongPressed: (foodConsumed) {},
  //       onFoodPressed: (foodConsumed) {},
  //     );
}
