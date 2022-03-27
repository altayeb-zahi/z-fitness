import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:z_fitness/ui/dumb_widgets/add_food_view_widgets/searched_food_history.dart';
import 'package:z_fitness/ui/views/add_food/add_food_view_model.dart';

import '../../../enums/meal_type.dart';
import '../../dumb_widgets/add_food_view_widgets/scan_barcode_and_quick_add.dart';
import '../../dumb_widgets/add_food_view_widgets/search_bar.dart';
import '../../dumb_widgets/add_food_view_widgets/searched_food_list_view.dart';

class AddFoodView extends StatefulWidget {
  final MealType mealType;
  const AddFoodView({
    Key? key,
    required this.mealType,
  }) : super(key: key);

  @override
  State<AddFoodView> createState() => _AddFoodViewState();
}

class _AddFoodViewState extends State<AddFoodView> {
  final model = AddFoodViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: Consumer<AddFoodViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
               iconTheme: const IconThemeData(
    color: Colors.black, //change your color here
  ),
              backgroundColor: Colors.white,
              elevation: 0,
              title:  Text(
                MealTypeString[widget.mealType]!,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchBar(onSearch: model.getSearchedFood, onClear: model.clearSearchResult,),
            
                  if(model.isBusy)
                   Center(child: Container(
                     margin: const EdgeInsets.only(top: 20),
                     child: const CircularProgressIndicator())),

                  if (model.searchedFood.isNotEmpty && !model.isBusy)
                    SearchedFoodListView(searchedFood: model.searchedFood),
                  if (model.searchedFood.isEmpty && !model.isBusy)
                    // show barcode scanner quick add and search history
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            BarcodeScannerAndQuickAdd(
                                onScanBarcode: () {}, onQuickAdd: () {}),
                            SearchedFoodHistory(
                              foodHistory: model.foodHistory,
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
