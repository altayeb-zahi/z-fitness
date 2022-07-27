import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:z_fitness/ui/smart_widgets/recipes_filters_bottom_sheet/recipes_filters_bottom_sheet_view_model.dart';

import '../../../enums/recipes_related_enums.dart';
import '../../../models/recipes_models/recipe_filters_settings.dart';
import '../../shared/ui_helpers.dart';

class RecipeBottomSheet extends StatefulWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  const RecipeBottomSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  State<RecipeBottomSheet> createState() => _RecipeBottomSheetState();
}

class _RecipeBottomSheetState extends State<RecipeBottomSheet> {
  final model = RecipeBottomSheetModel();

  @override
  void initState() {
    model.initilizeFiltersValues(widget.request!.data as RecipeFiltersSettings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<RecipeBottomSheetModel>(
        builder: (context, model, child) => Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filter Recipes Results'),
              verticalSpaceTiny,
              mealType(model),
              cuisineType(model),
              dietType(model),
              sortBy(model),
              intolerance(model),
              verticalSpaceMedium,
              saveAndCancelButtons(model, context),
            ],
          ),
        ),
      ),
    );
  }

  mealType(RecipeBottomSheetModel model) {
    return Expanded(
      child: Row(
        children: [
          const Text('Meal-Type'),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            child: DropdownButton(
              value: model.mealType,
              hint: const Text('show all measures '),
              isExpanded: false,
              items: model.mealTypesList
                  .map((e) => DropdownMenuItem(
                        onTap: () {},
                        value: e,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(recipeMealTypeToString[e]!),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                model.setMealType(value as RecipeMealType?);
              },
            ),
          ),
        ],
      ),
    );
  }

  cuisineType(RecipeBottomSheetModel model) {
    return Expanded(
      child: Row(
        children: [
          const Text('Cuisine'),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            child: DropdownButton(
              value: model.cuisine,
              isExpanded: false,
              items: model.cuisinesTypeList
                  .map((e) => DropdownMenuItem(
                        onTap: () {},
                        value: e,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(cuisineTypeToString[e]!),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                model.setCuisineType(value as CuisineType?);
              },
            ),
          ),
        ],
      ),
    );
  }

  dietType(RecipeBottomSheetModel model) {
    return Expanded(
      child: Row(
        children: [
          const Text('Diet'),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            child: DropdownButton(
              value: model.diet,
              isExpanded: false,
              items: model.dietTypesList
                  .map((e) => DropdownMenuItem(
                        onTap: () {},
                        value: e,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(dietTypeToString[e]!),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                model.setDietType(value as DietType?);
              },
            ),
          ),
        ],
      ),
    );
  }

  sortBy(RecipeBottomSheetModel model) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Sort By '),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            child: DropdownButton(
              value: model.sortBy,
              isExpanded: false,
              items: model.sortByList
                  .map((e) => DropdownMenuItem(
                        onTap: () {},
                        value: e,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(recipeSortByToString[e]!),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                model.setRecipeSortBy(value as RecipeSortBy?);
              },
            ),
          ),
        ],
      ),
    );
  }

  intolerance(RecipeBottomSheetModel model) {
    return Expanded(
      child: Row(
        children: [
          const Text('intolerance'),
          const Spacer(),
          Row(
            children: [
              if (model.intolerances!.isNotEmpty)
                Text(model.intolerances!.length.toString()),
              horizontalSpaceTiny,
              GestureDetector(
                  onTap: () => model.showIntoleranceDialog(),
                  child: const Icon(
                    Icons.arrow_drop_down,
                  )),
            ],
          )
        ],
      ),
    );
  }

  saveAndCancelButtons(RecipeBottomSheetModel model, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => widget.completer!(SheetResponse()),
          child: const Text('Canel'),
        ),
        horizontalSpaceMedium,
        GestureDetector(
          onTap: () => widget.completer!(SheetResponse(
              data: RecipeFiltersSettings(
                  recipeMealTypeToString[model.mealType!],
                  cuisineTypeToString[model.cuisine!],
                  dietTypeToString[model.diet!],
                  recipeSortByToString[model.sortBy!],
                  model.intolerances))),
          child: Text(
            'Save',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
