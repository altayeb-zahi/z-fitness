import 'package:flutter/material.dart';

import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/ui/views/food_details/food_details_view_model.dart';

class FoodDetailsView extends StatefulWidget {
  final FoodDetailsArgument foodDetailsArgument;
  const FoodDetailsView({
    Key? key,
    required this.foodDetailsArgument,
  }) : super(key: key);

  @override
  State<FoodDetailsView> createState() => _FoodDetailsViewState();
}

class _FoodDetailsViewState extends State<FoodDetailsView> {
  final model = FoodDetailsViewModel();

  @override
  void initState() {
    model.foodDetailsArgument = widget.foodDetailsArgument;
    model.onModelReady();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
