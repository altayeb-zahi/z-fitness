import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/views/diary/diary_view_model.dart';

import '../shared/ui_helpers.dart';

class FoodLayout extends StatelessWidget {
  final String title;
  final String addButtonTitle;

  final void Function() onAddPressed;
  // final Function(String something)? onFoodPressed;
  // final Function(int foodId)? onFoodLongPressed;
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  const FoodLayout({
    Key? key,
    required this.title,
    this.addButtonTitle = 'add food',
    required this.onAddPressed,
    // this.onFoodPressed,
    // this.onFoodLongPressed,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text(title),
            trailing:
                Consumer<DiaryViewModel>(builder: (context, model, child) {
              int _calories = 0;

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
        StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final _food =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(_food['name']),
                    subtitle: const Text('amount'),
                    trailing: Text(_food['calories']),
                  );
                },
              );
            }),
        GestureDetector(
          onTap: onAddPressed,
          child: Row(
            children:  [
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
