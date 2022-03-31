import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/ui/views/food_details/food_details_view_model.dart';

import '../../../enums/food_type.dart';
import '../../shared/ui_helpers.dart';

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
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<FoodDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
           appBar: AppBar(
              title: (const Text('food details')),
              actions: [
                GestureDetector(
                    onTap: () => model.addFoodToDatabase(),
                    child: const Icon(Icons.check)),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            body: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : _body(model, widget.foodDetailsArgument.foodType, context)),
      ),
    );
  }

  
  _body(
    FoodDetailsViewModel model,
    FoodType foodType,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          _foodName(model, context),
          const Divider(),
          _numberOfServing(model, context),
          const Divider(),
          _servingQty(model, context),
          const Divider(),
          _servingWeight(model, context),
          const Divider(),
          _caloriesProtienCarbFat(model, context),
        
        ],
      ),
    );
  }

  _foodName(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Container(
        height: 40,
        margin: EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        child: Text(
          model.nutritienstDetail!.foods![0]!.foodName ?? '',
          style: theme.textTheme.bodyText1,
        ));
  }

  _numberOfServing(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => model.setNumberOfServing(),
      child: Container(
          height: 40,
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                'number of seving',
                style: theme.textTheme.bodyText1,
              ),
              const Expanded(
                  child: SizedBox(
                height: 5,
                width: 5,
              )),
              Text(
                model.nutritienstDetail!.foods![0]!.servingQty.toString(),
                // style: theme.textTheme.headline2,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )),
    );
  }

  _servingQty(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => model.setNumberOfServing(),
      child: Container(
          height: 40,
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                'serving Qty  ',
                style: theme.textTheme.bodyText1,
              ),
              const Expanded(
                  child: SizedBox(
                height: 5,
                width: 5,
              )),
              Text(
                model.nutritienstDetail!.foods![0]!.servingQty.toString() +
                    ' ' +
                    model.nutritienstDetail!.foods![0]!.servingUnit.toString(),
                // style: theme.textTheme.headline2,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )),
    );
  }

  _caloriesProtienCarbFat(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              const Text(
                'calories',
                // style: theme.textTheme.bodyText1,
              ),
              verticalSpaceRegular,
              Text(
                model.nutritienstDetail!.foods![0]!.nfCalories!
                        .round()
                        .toString() +
                    ' ' +
                    'kcal',
                // style: theme.textTheme.headline2,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                'protien',
                // style: theme.textTheme.bodyText1,
              ),
              verticalSpaceRegular,
              Text(
                model.nutritienstDetail!.foods![0]!.nfProtein!
                        .round()
                        .toString() +
                    '',
                // style: theme.textTheme.headline2,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'carb',
                style: theme.textTheme.bodyText1,
              ),
              verticalSpaceRegular,
              Text(
                model.nutritienstDetail!.foods![0]!.nfTotalCarbohydrate!
                        .round()
                        .toString() +
                    '',
                // style: theme.textTheme.headline2,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                'fat',
                // style: theme.textTheme.bodyText1,
              ),
              verticalSpaceRegular,
              Text(
                model.nutritienstDetail!.foods![0]!.nfTotalFat!
                        .round()
                        .toString() +
                    '',
                // style: theme.textTheme.headline2,
              )
            ],
          ),
        ),
      ],
    );
  }

  _servingWeight(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => model.setNumberOfServing(),
      child: Container(
          height: 40,
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                'serving weight  ',
                style: theme.textTheme.bodyText1,
              ),
              const Expanded(
                  child: SizedBox(
                height: 5,
                width: 5,
              )),
              Text(
                model.nutritienstDetail!.foods![0]!.servingWeightGrams
                        .toString() +
                    ' g',
                // style: theme.textTheme.headline2,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )),
    );
  }

}
