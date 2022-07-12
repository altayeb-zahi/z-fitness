import 'package:flutter/material.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import '../shared/ui_helpers.dart';

//TODO delete this widget after implementing the water and exercises functionalities
class FoodLayout2 extends StatelessWidget {
  final String title;
  final String addButtonTitle;

  final void Function() onAddPressed;
  final void Function(FoodConsumed foodConsumed) onFoodPressed;
  final void Function(FoodConsumed foodConsumed) onFoodLongPressed;

  const FoodLayout2({
    Key? key,
    // this.onFoodPressed,
    // this.onFoodLongPressed,
    required this.title,
    this.addButtonTitle = 'ADD FOOD',
    required this.onAddPressed,
    required this.onFoodPressed,
    required this.onFoodLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
      child: Column(
        children: [
          Row(
            children: [
              Text(title,
                  style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyText2!.color)),
              Expanded(child: Container()),
              const Text('0'),
            ],
          ),

          verticalSpaceTiny,
          dividerTiny,
          // verticalSpaceRegular,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 0,
            itemBuilder: (context, index) {
              return const Text('0');
            },
          ),
          GestureDetector(
            onTap: onAddPressed,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  verticalSpaceSmall,
                  Text(
                    addButtonTitle,
                    style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.primary,
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
