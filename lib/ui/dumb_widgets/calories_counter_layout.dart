import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';
import 'package:z_fitness/ui/shared/ui_helpers.dart';

import 'package:z_fitness/ui/views/diary/diary_view_model.dart';

class CaloriesCounterLayout extends StatelessWidget {
  const CaloriesCounterLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Consumer<DiaryViewModel>(
        builder: (context, model, child) => StreamBuilder(
          stream: CombineLatestStream.list([
            model.getBreaktotalCalories(),
            model.getLunchtotalCalories(),
            model.getDinnerTotalCalories(),
            model.getSnacksTotalCalories(),
            // model.getExerciseTotalCalories()
          ]),
          builder: (context, snapshot) {
            int _caloriesGoal = model.currentUser.dailyCaloriesGoal!.round();
            int _totalCaloiresConsumed = 0;
            int _totalCaloriesBurned = 0;
            int _caloriesRemaining = 0;
            if (snapshot.hasError) {
              throw (Exception(snapshot.error));
            }

            if (snapshot.hasData) {
              final data = snapshot.data! as List<int>;
              final _breakfastCalories = data[0];
              final _lunchCalories = data[1];
              final _dinnerCalories = data[2];
              final _snacksCalories = data[3];
              // final _totalCaloriesBurned = data[4];

              _totalCaloiresConsumed = _breakfastCalories +
                  _lunchCalories +
                  _dinnerCalories +
                  _snacksCalories;

              _caloriesRemaining =
                  _caloriesGoal - _totalCaloiresConsumed + _totalCaloriesBurned;
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              Container();
            }

            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Calories Remaining',
                        style: theme.textTheme.headline3!),
                    verticalSpaceRegular,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text(
                            _caloriesGoal.toString(),
                            style: theme.textTheme.headline4,
                          ),
                          Text(
                            'Goal',
                            style: theme.textTheme.caption,
                          )
                        ]),
                        Text('-', style: theme.textTheme.headline3),
                        Column(children: [
                          Text(
                            _totalCaloiresConsumed.toString(),
                            style: theme.textTheme.headline4,
                          ),
                          Text(
                            'Food',
                            style: theme.textTheme.caption,
                          )
                        ]),
                        Text('+', style: theme.textTheme.headline3),
                        Column(children: [
                          Text(
                            _totalCaloriesBurned.toString(),
                            style: theme.textTheme.headline4,
                          ),
                          Text(
                            'Exercise',
                            style: theme.textTheme.caption,
                          )
                        ]),
                        Text('=', style: theme.textTheme.headline3),
                        Column(children: [
                          Text(
                            _caloriesRemaining.toString(),
                            style: theme.textTheme.headline3!.copyWith(
                                color: primaryColorLight,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Remaining',
                            style: theme.textTheme.caption,
                          ),
                        ])
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
