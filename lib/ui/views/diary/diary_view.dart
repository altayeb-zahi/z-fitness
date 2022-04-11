import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:z_fitness/enums/meal_type.dart';
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
    model.getCaloriesDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                _tableCalender(),
                divider,
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
      ),
    );
  }

  Widget _tableCalender() => Consumer<DiaryViewModel>(
        builder: (context, model, child) => TableCalendar(
          // calendarStyle: CalendarStyle(
          //     selectedDecoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //          color: theme.accentColor
          //          )
          //          ),
          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
          // 0 to get last day from previous month
          lastDay: DateTime.utc(DateTime.now().year + 1, 1, 0),
          focusedDay: model.focusedDay,
          calendarFormat: CalendarFormat.week,
          rowHeight: 0,
          daysOfWeekVisible: false,
          selectedDayPredicate: (day) {
            return isSameDay(model.selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) =>
              model.onDaySelected(selectedDay, focusedDay),
        ),
      );

  Widget _caloriesRemaining() => Consumer<DiaryViewModel>(
        builder: (context, model, child) => CaloriesCounterLayout(
          caloriesDetails: model.caloriesDetails,
        ),
      );

  Widget _breakfast() => FoodLayout(
        title: 'Breakfast',
        stream: model.getBreakfastMeals(),
        onAddPressed: () =>
            model.navigateToAddFood(mealType: MealType.breakfast),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _lunch() => FoodLayout(
        title: 'Lunch',
        stream: model.getLunchMeals(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.lunch),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _dinner() => FoodLayout(
        title: 'Dinner',
        stream: model.getDinnerMeals(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.dinner),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _snaks() => FoodLayout(
        title: 'Snacks',
        stream: model.getSnacks(),
        onAddPressed: () => model.navigateToAddFood(mealType: MealType.snacks),
        onFoodLongPressed: (foodConsumed) =>
            model.onFoodLongPressed(foodConsumed),
        onFoodPressed: (foodConsumed) => model.onFoodPressed(foodConsumed),
      );

  Widget _exercises() => FoodLayout(
        title: 'Exercise',
        addButtonTitle: 'add exercise',
        stream: model.getExercises(),
        onAddPressed: () {},
        onFoodLongPressed: (foodConsumed) {},
        onFoodPressed: (foodConsumed) {},
      );

  Widget _water() => FoodLayout(
        title: 'Water',
        addButtonTitle: 'add water',
        stream: model.getWater(),
        onAddPressed: () {},
        onFoodLongPressed: (foodConsumed) {},
        onFoodPressed: (foodConsumed) {},
      );
}
