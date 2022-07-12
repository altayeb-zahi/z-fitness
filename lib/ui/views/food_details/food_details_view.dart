import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/ui/views/food_details/food_details_view_model.dart';
import '../../../enums/food_type.dart';
import '../../shared/ui_helpers.dart';

double _padding = 15;

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
    model.getFoodNutritionDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<FoodDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: (const Text(
                'Food Details',
              )),
            ),
            body: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : _body(model, widget.foodDetailsArgument.foodType, context)),
      ),
    );
  }

  Widget _body(
    FoodDetailsViewModel model,
    FoodType foodType,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(horizontalViewPading),
      child: ListView(
        children: [
          _title(model, context),
          dividerSmall,
          _numberOfServing(model, context),
          dividerSmall,
          _servingQty(model, context),
          dividerSmall,
          _servingWeight(model, context),
          dividerSmall,
          _caloriesProtienCarbFat(model, context),
          verticalSpaceLarge,
          _addButton(model, context)
        ],
      ),
    );
  }

  Widget _title(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: Text(
        model.nutritienstDetail!.foods![0]!.foodName ?? '',
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  Widget _numberOfServing(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: GestureDetector(
        onTap: () => model.setNumberOfServing(),
        child: Row(
          children: [
            const Text(
              'Number of servings',
            ),
            const Spacer(),
            Text(model.nutritienstDetail!.foods![0]!.servingQty.toString(),
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }

  Widget _servingQty(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: GestureDetector(
        onTap: () => model.setNumberOfServing(),
        child: Row(
          children: [
            const Text(
              'Serving Qty  ',
            ),
            const Spacer(),
            Text(
                model.nutritienstDetail!.foods![0]!.servingQty.toString() +
                    ' ' +
                    model.nutritienstDetail!.foods![0]!.servingUnit.toString(),
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }

  Widget _servingWeight(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: GestureDetector(
        onTap: () => model.setNumberOfServing(),
        child: Row(
          children: [
            const Text(
              'Serving weight  ',
            ),
            const Spacer(),
            Text(
              model.nutritienstDetail!.foods![0]!.servingWeightGrams
                      .toString() +
                  ' g',
              style: theme.textTheme.titleMedium!
                  .copyWith(color: theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _caloriesProtienCarbFat(
      FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _padding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Calories',
                ),
                verticalSpaceSmall,
                Text(
                    model.nutritienstDetail!.foods![0]!.nfCalories!
                            .round()
                            .toString() +
                        ' ' +
                        'kcal',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.colorScheme.primary))
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Protien',
                ),
                verticalSpaceSmall,
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
                const Text(
                  'Carb',
                ),
                verticalSpaceSmall,
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
                  'Fat',
                ),
                verticalSpaceSmall,
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
      ),
    );
  }

  Widget _addButton(FoodDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => model.onMainButtonPressed(),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          ' ADD',
          style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
