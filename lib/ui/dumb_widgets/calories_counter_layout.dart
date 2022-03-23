import 'package:flutter/material.dart';

import 'package:z_fitness/models/calories_details.dart';

class CaloriesCounterLayout extends StatelessWidget {
  final CaloriesDetails caloriesDetails;
  const CaloriesCounterLayout({
    Key? key,
    required this.caloriesDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          const ListTile(
            title: Text('Calories Remaining'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text(caloriesDetails.dailyCaloriesGoal.toString()),
                const Text(
                  'Goal',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              const Text('-'),
              Column(children: [
                Text(caloriesDetails.totalCaloriesConsumed.toString()),
                const Text(
                  'Food',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              const Text('+'),
              Column(children: [
                Text(caloriesDetails.caloriesBurned.toString()),
                const Text(
                  'Exercise',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              const Text('='),
              Column(children: [
                Text(caloriesDetails.caloriesRemaining.toString()),
                const Text(
                  'Remaining',
                  style: TextStyle(fontSize: 12),
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
