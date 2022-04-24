import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/ui/dumb_widgets/add_food_view_widgets/searched_food_history.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';
import 'package:z_fitness/ui/views/add_food/add_food_view_model.dart';

import '../../../enums/meal_type.dart';
import '../../dumb_widgets/add_food_view_widgets/scan_barcode_and_quick_add.dart';
import '../../dumb_widgets/add_food_view_widgets/search_bar.dart';
import '../../dumb_widgets/add_food_view_widgets/searched_food_list_view.dart';
import '../../shared/ui_helpers.dart';

class AddFoodView extends StatefulWidget {
  final AddFoodArgument addFoodArgument;
  const AddFoodView({
    Key? key,
    required this.addFoodArgument,
  }) : super(key: key);

  @override
  State<AddFoodView> createState() => _AddFoodViewState();
}

class _AddFoodViewState extends State<AddFoodView> {
  final model = AddFoodViewModel();

  @override
  void initState() {
    model.addFoodArgument = widget.addFoodArgument;
    model.getFoodHistory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: Consumer<AddFoodViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: kcScafoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                mealTypeToString[widget.addFoodArgument.mealType]!,
                style: theme.textTheme.headline3,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchBar(
                    onSearch: model.getSearchedFood,
                    onClear: model.clearSearchResult,
                  ),
                  if (model.isBusy)
                    Center(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const CircularProgressIndicator())),
                  if (model.searchedFood.isNotEmpty && !model.isBusy)
                    SearchedFoodListView(
                      searchedFood: model.searchedFood,
                      onFoodPressed: (foodType, selectedFoodId) =>
                          model.navigateToFoodDetails(FoodDetailsArgument(
                              date: widget.addFoodArgument.date,
                              foodType: foodType,
                              selectedFoodId: selectedFoodId,
                              mealType: widget.addFoodArgument.mealType)),
                    ),
                  if (model.searchedFood.isEmpty && !model.isBusy)
                    // show barcode scanner quick add and search history
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            BarcodeScannerAndQuickAdd(
                                onScanBarcode: () {}, onQuickAdd: () {}),
                 verticalSpaceRegular,

                            SearchedFoodHistory(
                              foodHistory: model.foodHistory,
                              onHistoryItemPressed: (foodConsumed) =>
                                  model.onHistoryItemPressed(foodConsumed),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
