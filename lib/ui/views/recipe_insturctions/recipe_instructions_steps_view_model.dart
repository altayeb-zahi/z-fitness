import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/models/recipes_models/recipe_steps.dart' as step;

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
                padding: const EdgeInsets.all(20.0),
                child: PageView(
                    children: model.recipeSteps![0].steps!
                        .map((s) => instructionsBody(s, model, context))
                        .toList()),
              ),
        ),
      ),
    );
  }

   Widget instructionsBody(step.Step s, RecipeInstructionsViewModel model,
      BuildContext context) {
    // var theme = Theme.of(context);
    return ListView(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(
          children: [
            Text(
                'Step (${s.number.toString()}/${model.recipeSteps![0].steps!.length})',
                // style: theme.textTheme.headline1
                ),
            Expanded(
              child: Container(),
            ),
            s.number == model.recipeSteps![0].steps!.length
                ? Container()
                : const Icon(Icons.keyboard_arrow_right_outlined)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            // color: theme.backgroundColor,
            padding: const EdgeInsets.all(10),
            child: Text(s.step!,
            //  style: theme.textTheme.bodyText1
             )),
        const SizedBox(
          height: 30,
        ),
        s.equipment!.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Equipments',
                  //  style: theme.textTheme.headline1
                   ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var url =
                          'https://spoonacular.com/cdn/equipment_100x100/';

                      return Container(
                        decoration: BoxDecoration(
                            // color: theme.backgroundColor,
                            border: Border.all(
                                // color: theme.scaffoldBackgroundColor
                                ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        margin: const EdgeInsets.all(3),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: url + s.equipment![index].image!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                          title: Text(s.equipment![index].name!,
                              // style: theme.textTheme.bodyText1
                              ),
                        ),
                      );
                    },
                    itemCount: s.equipment!.length,
                  ),
                ],
              ),
        const SizedBox(
          height: 10,
        ),
        const Text('Ingredients', 
        // style: theme.textTheme.headline1
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var url = 'https://spoonacular.com/cdn/ingredients_100x100/';

            return Container(
              decoration: BoxDecoration(
                  // color: theme.backgroundColor,
                  border: Border.all(
                    // color: theme.scaffoldBackgroundColor
                    ),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              margin: const EdgeInsets.all(3),
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: url + s.ingredients![index].image!,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
                title: Text(s.ingredients![index].name!,
                    // style: theme.textTheme.bodyText1
                    ),
              ),
            );
          },
          itemCount: s.ingredients!.length,
        ),
      ]),
    ]);
  }
}
