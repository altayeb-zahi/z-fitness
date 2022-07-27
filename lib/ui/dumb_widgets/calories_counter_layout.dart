import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:z_fitness/ui/shared/ui_helpers.dart';

import 'package:z_fitness/ui/views/diary/diary_view_model.dart';

import '../../app/logger.dart';
import '../../models/user.dart';

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
            // model.getDailyCaloriesgoal(),

            // model.getExerciseTotalCalories()
          ]),
          builder: (context, snapshot) {
            int _caloriesGoal = model.caloriesGoal;
            int _totalCaloiresConsumed = 0;
            int _totalCaloriesBurned = 0;
            int _caloriesRemaining = model.caloriesGoal;

            if (snapshot.hasError) {
              throw (Exception(snapshot.error));
            }

            if (snapshot.hasData) {
              log.i('snapshot has data');

              final data = snapshot.data! as List<int>;
              final _breakfastCalories = data[0];
              final _lunchCalories = data[1];
              final _dinnerCalories = data[2];
              final _snacksCalories = data[3];
              // _caloriesGoal = data[4];

              _totalCaloiresConsumed = _breakfastCalories +
                  _lunchCalories +
                  _dinnerCalories +
                  _snacksCalories;

              _caloriesRemaining =
                  _caloriesGoal - _totalCaloiresConsumed + _totalCaloriesBurned;
            } else {
              log.i('snapshot does not has data');
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
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.bold)),
                    verticalSpaceRegular,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text(
                            _caloriesGoal.toString(),
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            'Goal',
                            style: theme.textTheme.caption,
                          )
                        ]),
                        Text('-', style: theme.textTheme.titleMedium),
                        Column(children: [
                          Text(
                            _totalCaloiresConsumed.toString(),
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            'Food',
                            style: theme.textTheme.caption,
                          )
                        ]),
                        Text('+', style: theme.textTheme.titleMedium),
                        Column(children: [
                          Text(
                            _totalCaloriesBurned.toString(),
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            'Exercise',
                            style: theme.textTheme.caption,
                          )
                        ]),
                        Text('=', style: theme.textTheme.titleMedium),
                        Column(children: [
                          Text(
                            _caloriesRemaining.toString(),
                            style: theme.textTheme.titleSmall!.copyWith(
                                color: theme.colorScheme.primary,
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
