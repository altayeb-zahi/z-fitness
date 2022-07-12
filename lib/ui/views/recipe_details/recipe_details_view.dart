import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:unicons/unicons.dart';
import 'package:z_fitness/models/arguments_models.dart';

import 'package:z_fitness/ui/views/recipe_details/recipe_details_view_model.dart';

import '../../../utils/helpers.dart';
import '../../shared/ui_helpers.dart';

class RecipeDetailsView extends StatefulWidget {
  //TODO change the image size from the website to suitable size
  final RecipeDetailsArgument recipeDetailsArgument;
  const RecipeDetailsView({
    Key? key,
    required this.recipeDetailsArgument,
  }) : super(key: key);

  @override
  State<RecipeDetailsView> createState() => _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends State<RecipeDetailsView> {
  final model = RecipeDetailsViewModel();

  @override
  void initState() {
    model.recipeDetailsArgument = widget.recipeDetailsArgument;
    model.onModelReady();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<RecipeDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
            body: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _recipeImage(model),
                          Padding(
                            padding: const EdgeInsets.all(horizontalViewPading),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpaceTiny,
                                _titleAndSummary(model),
                                verticalSpaceMedium,
                                _addToDiary(model),
                                verticalSpaceMedium,
                                _calories(model),
                                verticalSpaceMedium,
                                tabBar(model, context)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }

  _titleAndSummary(RecipeDetailsViewModel model) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.recipeDetails!.title!,
          style: theme.textTheme.titleLarge!
              .copyWith(color: theme.colorScheme.secondary),
        ),
        verticalSpaceSmall,
        ReadMoreText(
          parseHtmlString(model.recipeDetails!.summary!),
          style: theme.textTheme.bodyText2!.copyWith(
              wordSpacing: 1.7, color: theme.textTheme.caption!.color),
          colorClickableText: theme.colorScheme.primary,
          trimLength: 110,
        )
      ],
    );
  }

  _addToDiary(RecipeDetailsViewModel model) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(horizontalViewPading),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(children: [
          Icon(
            Icons.add_alarm_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          verticalSpaceSmall,
          Text(
            model.recipeDetails!.readyInMinutes.toString() + ' min',
            style: theme.textTheme.caption,
          )
        ]),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              model.navigateToRecipeStepsInstructions(model.recipeDetails!.id),
          child: Column(children: [
            Icon(
              UniconsLine.notes,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            verticalSpaceSmall,
            Text(
              'start cocking',
              style: theme.textTheme.caption,
            )
          ]),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => model.selectMealType(),
          child: Column(children: [
            Icon(Icons.add, color: theme.colorScheme.onSurfaceVariant),
            verticalSpaceSmall,
            Text(
              'add to Diary',
              style: theme.textTheme.caption,
            )
          ]),
        ),
      ]),
    );
  }

  _calories(RecipeDetailsViewModel model) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text('calories', style: theme.textTheme.caption),
              verticalSpaceSmall,
              Text(
                  '${model.recipeDetails!.recipeToNutrients!.calories.toString()} kcal',
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary)),
              const Text('')
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'protien',
                style: theme.textTheme.caption,
              ),
              verticalSpaceSmall,
              Text(
                  model.recipeDetails!.nutrition!.caloricBreakdown!
                          .percentProtein!
                          .round()
                          .toString() +
                      ' %',
                  style: theme.textTheme.caption!
                      .copyWith(color: theme.colorScheme.tertiary)),
              verticalSpaceTiny,
              Text(
                model.recipeDetails!.recipeToNutrients!.protein.toString() +
                    ' g',
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('carb', style: theme.textTheme.caption),
              verticalSpaceSmall,
              Text(
                  model.recipeDetails!.nutrition!.caloricBreakdown!
                          .percentCarbs!
                          .round()
                          .toString() +
                      ' %',
                  style: theme.textTheme.caption!
                      .copyWith(color: theme.colorScheme.tertiary)),
              verticalSpaceTiny,
              Text(
                model.recipeDetails!.recipeToNutrients!.carb.toString() + ' g',
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('fat', style: theme.textTheme.caption),
              verticalSpaceSmall,
              Text(
                  model.recipeDetails!.nutrition!.caloricBreakdown!.percentFat!
                          .round()
                          .toString() +
                      ' %',
                  style: theme.textTheme.caption!
                      .copyWith(color: theme.colorScheme.tertiary)),
              verticalSpaceTiny,
              Text(
                model.recipeDetails!.recipeToNutrients!.fat.toString() + ' g',
              )
            ],
          ),
        ),
      ],
    );
  }

  _recipeImage(RecipeDetailsViewModel model) => CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: model.recipeDetails!.image!,
      );

  tabBar(RecipeDetailsViewModel model, BuildContext context) {
    return SizedBox(
      height: 500,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: const [
                TabBar(
                  tabs: [
                    Tab(
                      text: 'Ingredients',
                    ),
                    Tab(
                      text: 'Nutrients',
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              showIngredients(model, context),
              showNutrients(model, context),
            ],
          ),
        ),
      ),
    );
  }

  showIngredients(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var url = 'https://spoonacular.com/cdn/ingredients_100x100/';
        var ingredient = model.recipeDetails!.extendedIngredients![index];
        return ListTile(
          leading: CachedNetworkImage(
            height: 50,
            width: 50,
            imageUrl: url + ingredient.image!,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
          title: Text(ingredient.name!),
          subtitle: Text(
            ingredient.amount!.toStringAsFixed(2) +
                ' ' +
                ingredient.measures!.metric!.unitShort!,
          ),
        );
      },
      itemCount: model.recipeDetails!.extendedIngredients!.length,
    );
  }

  showNutrients(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        title: Text(
          model.recipeDetails!.nutrition!.nutrients![index].name!,
        ),
        trailing: Text(
          model.recipeDetails!.nutrition!.nutrients![index].amount.toString(),
        ),
      ),
      itemCount: model.recipeDetails!.extendedIngredients!.length,
    );
  }
}
