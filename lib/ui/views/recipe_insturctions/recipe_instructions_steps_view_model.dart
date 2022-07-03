import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/models/recipes_models/recipe_steps.dart' as step;
import 'package:z_fitness/ui/shared/app_colors.dart';
import 'package:z_fitness/ui/shared/ui_helpers.dart';

import 'package:z_fitness/ui/views/recipe_insturctions/recipe_instructions_steps_view.dart';

class RecipeInstructionsView extends StatefulWidget {
  final int id;
  const RecipeInstructionsView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RecipeInstructionsView> createState() => _RecipeInstructionsViewState();
}

class _RecipeInstructionsViewState extends State<RecipeInstructionsView> {
  final model = RecipeInstructionsViewModel();

  @override
  void initState() {
    model.getRecipeSteps(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<RecipeInstructionsViewModel>(
        builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  // color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalViewPading),
                  child: PageView(
                      children: model.recipeSteps![0].steps!
                          .map((s) => instructionsBody(s, model, context))
                          .toList()),
                ),
        ),
      ),
    );
  }

  Widget instructionsBody(
      step.Step step, RecipeInstructionsViewModel model, BuildContext context) {
    final theme = Theme.of(context);
    return ListView(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(
          children: [
            Text(
                'Step (${step.number.toString()}/${model.recipeSteps![0].steps!.length})',
                style: theme.textTheme.headline3),
            Expanded(
              child: Container(),
            ),
            step.number == model.recipeSteps![0].steps!.length
                ? Container()
                : const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: primaryColorLight,
                  )
          ],
        ),
        verticalSpaceRegular,
        Text(step.step!,
            style: theme.textTheme.bodyText2!
                .copyWith(height: 1.5, color: kcDarkGreyColorLight)),
        step.equipment!.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceRegular,
                  Text('Equipments', style: theme.textTheme.headline3),
                  verticalSpaceRegular,
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var url =
                          'https://spoonacular.com/cdn/equipment_100x100/';

                      return Container(
                        decoration: const BoxDecoration(
                            color: backgroundColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: url + step.equipment![index].image!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                          title: Text(
                            step.equipment![index].name!,
                            // style: theme.textTheme.bodyText1
                          ),
                        ),
                      );
                    },
                    itemCount: step.equipment!.length,
                  ),
                ],
              ),
        verticalSpaceRegular,
        Text('Ingredients', style: theme.textTheme.headline3),
        verticalSpaceRegular,
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var url = 'https://spoonacular.com/cdn/ingredients_100x100/';

            return Container(
              decoration: const BoxDecoration(
                  color: backgroundColorLight,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: url + step.ingredients![index].image!,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
                title: Text(
                  step.ingredients![index].name!,
                  // style: theme.textTheme.bodyText1
                ),
              ),
            );
          },
          itemCount: step.ingredients!.length,
        ),
      ]),
    ]);
  }
}
