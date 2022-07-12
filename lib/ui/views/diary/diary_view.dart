import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/enums/meal_type.dart';
import '../../dumb_widgets/food_layout_temporary.dart';
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
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (() => model.onDateArrowPressed(isForoward: false)),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                    onTap: () => model.pickDate(context),
                    child: Consumer<DiaryViewModel>(
                        builder: (context, model, child) => Text(
                              model.dateTitle,
                              style: theme.textTheme.titleMedium,
                            ))),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: (() => model.onDateArrowPressed()),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: theme.colorScheme.primary,
                  ),
                )
              ],
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  _caloriesRemaining(),
                  divider,
                  _breakfast(),
                  divider,
                  _lunch(),
                  divider,
                  _dinner(),
                  divider,
                  _snaks(),
                  divider,
                  _exercises(),
                  divider,
                  _water(),
                  divider
                ],
              ),
            ),
          ),
        ));
  }

  Widget _caloriesRemaining() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
        child: Consumer<DiaryViewModel>(
          builder: (context, model, child) => const CaloriesCounterLayout(),
        ),
      );

  Widget _breakfast() => FoodLayout(
        title: 'BREAKFAST',
        mealsConsumedStream: model.getBreakfastMeals(),
        mealTotalCaloriesStream: model.getBreaktotalCalories(),
        onAddPressed: () =>
            model.navigateToAddFood(mealType: MealType.breakfast),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _lunch() => FoodLayout(
        title: 'LUNCH',
        mealsConsumedStream: model.getLunchMeals(),
        mealTotalCaloriesStream: model.getLunchtotalCalories(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.lunch),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _dinner() => FoodLayout(
        title: 'DINNER',
        mealsConsumedStream: model.getDinnerMeals(),
        mealTotalCaloriesStream: model.getDinnerTotalCalories(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.dinner),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _snaks() => FoodLayout(
        title: 'SNACKS',
        mealsConsumedStream: model.getSnacks(),
        mealTotalCaloriesStream: model.getSnacksTotalCalories(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.snacks),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _exercises() => FoodLayout2(
        title: 'EXERCISE',
        addButtonTitle: 'ADD EXERCISE',
        onAddPressed: () {},
        onFoodLongPressed: (foodConsumed) {},
        onFoodPressed: (foodConsumed) {},
      );

  Widget _water() => FoodLayout2(
        title: 'WATER',
        addButtonTitle: 'ADD WATER',
        onAddPressed: () {},
        onFoodLongPressed: (foodConsumed) {},
        onFoodPressed: (foodConsumed) {},
      );
}
