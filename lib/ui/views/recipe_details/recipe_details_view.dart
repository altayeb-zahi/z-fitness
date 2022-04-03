import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:z_fitness/ui/views/recipe_details/recipe_details_view_model.dart';

import '../../../models/recipes_models/recipe_search.dart';
import '../../../utils/helpers.dart';
import '../../shared/ui_helpers.dart';

class RecipeDetailsView extends StatefulWidget {
  //TODO change the image size from the website to suitable size
  final RecipeResult result;
  const RecipeDetailsView({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  State<RecipeDetailsView> createState() => _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends State<RecipeDetailsView> {
  final model = RecipeDetailsViewModel();

  @override
  void initState() {
    model.getRecipeDetails(widget.result.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<RecipeDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
               iconTheme: const IconThemeData(
    color: Colors.black
  ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _recipeImage(model),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _titleAndSummary(model),
                              verticalSpaceSmall,
                              _addToDiary(model),
                              verticalSpaceSmall,
                              _calories(model),
                              verticalSpaceSmall,
                              _ingrediants(model)
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
      ),
    );
  }

  _titleAndSummary(RecipeDetailsViewModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.recipeDetails!.title!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          verticalSpaceSmall,
          ReadMoreText(
            parseHtmlString(model.recipeDetails!.summary!),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
            trimLines: 4,
          )
        ],
      );

  _addToDiary(RecipeDetailsViewModel model) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(children: [
              const Icon(Icons.add_alarm_outlined),
              verticalSpaceSmall,
              Text(
                model.recipeDetails!.readyInMinutes.toString() + ' min',
                // style: theme.textTheme.bodyText2,
              )
            ]),
            Column(children: [
              const Icon(Icons.favorite_border_outlined),
              verticalSpaceSmall,
              Text(
                model.recipeDetails!.spoonacularScore.toString(),
                // style: theme.textTheme.bodyText2,
              )
            ]),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => model.navigateToRecipeStepsInstructions(
                  model.recipeDetails!.id),
              child: Column(children: const [
                Icon(Icons.kitchen_outlined),
                verticalSpaceSmall,
                Text(
                  'start cocking',
                  // style: theme.textTheme.bodyText2,
                )
              ]),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => model.selectMealType(),
              child: Column(children: const [
                Icon(Icons.add),
                verticalSpaceSmall,
                Text(
                  'add to Diary',
                  // style: theme.textTheme.bodyText2,
                )
              ]),
            ),
          ]),
        ),
      );

  _calories(RecipeDetailsViewModel model) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('calories'
                        // , style: theme.textTheme.bodyText1
                        ),
                    verticalSpaceSmall,
                    Text(
                      '${model.recipeDetails!.recipeToNutrients!.calories.toString()} kcal',
                      // style: theme.textTheme.headline2
                    ),
                    const Text('')
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
                    verticalSpaceSmall,
                    Text(
                      model.recipeDetails!.nutrition!.caloricBreakdown!
                              .percentProtein!
                              .round()
                              .toString() +
                          ' %',
                      // style: theme.textTheme.bodyText2
                    ),
                    Text(
                      model.recipeDetails!.recipeToNutrients!.protein.toString() + ' g',
                      // style: theme.textTheme.bodyText1
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'carb',

                      //  style: theme.textTheme.bodyText1
                    ),
                    verticalSpaceSmall,
                    Text(
                      model.recipeDetails!.nutrition!.caloricBreakdown!
                              .percentCarbs!
                              .round()
                              .toString() +
                          ' %',
                      // style: theme.textTheme.bodyText2
                    ),
                    Text(
                      model.recipeDetails!.recipeToNutrients!.carb.toString() + ' g',
                      // style: theme.textTheme.bodyText1
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'fat',
                      //  style: theme.textTheme.bodyText1
                    ),
                    verticalSpaceSmall,
                    Text(
                      model.recipeDetails!.nutrition!.caloricBreakdown!
                              .percentFat!
                              .round()
                              .toString() +
                          ' %',
                      // style: theme.textTheme.bodyText2
                    ),
                    Text(
                      model.recipeDetails!.recipeToNutrients!.fat.toString() + ' g',
                      // style: theme.textTheme.bodyText1
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _recipeImage(RecipeDetailsViewModel model) => CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: model.recipeDetails!.image!,
      );

  _ingrediants(RecipeDetailsViewModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingrediants',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var url = 'https://spoonacular.com/cdn/ingredients_100x100/';
                var ingredient =
                    model.recipeDetails!.extendedIngredients![index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          height: 50,
                          width: 50,
                          imageUrl: url + ingredient.image!,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                        Text(model.recipeDetails!
                            .extendedIngredients![index].name!),
                      ],
                    ),
                  ),
                );
              },
              itemCount: model.recipeDetails!.extendedIngredients!.length,
            ),
          ),
        ],
      );
}
