import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/dumb_widgets/add_food_view_widgets/search_bar.dart';
import 'package:z_fitness/ui/views/recipes/recipes_view_model.dart';

import '../../../enums/recipes_related_enums.dart';
import '../../dumb_widgets/creation_aware_list_items.dart';
import '../../shared/ui_helpers.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  final model = RecipesViewModel();
  final _searchRecipeTex = TextEditingController();

  @override
  void initState() {
    model.initialiseRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<RecipesViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Recipes',
              ),
              elevation: 0,
              actions: [
                GestureDetector(
                    onTap: () => model.showBottomSheet(),
                    child: Icon(
                      Icons.tune_outlined,
                      color: theme.colorScheme.primary,
                    )),
                const SizedBox(width: 15)
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalViewPading),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBar(
                    onSearch: (String text) {
                      if (text.isNotEmpty && text != '') {
                        model.getRecipes(searchTex: text);
                      }
                    },
                    onClear: () => model.clearSearchedRecipes(),
                    hint: 'Search for Recipes',
                  ),
                  model.isBusy
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: CircularProgressIndicator(),
                        ))
                      : (model.searchedRecipes!.isNotEmpty ||
                              _searchRecipeTex.text != '')
                          ? searchedRecipesBody(
                              model, context, _searchRecipeTex)
                          : recipesBody(model, context)
                ],
              ),
            )),
      ),
    );
  }
}

Widget searchedRecipesBody(RecipesViewModel model, BuildContext context,
    TextEditingController? searchRecipeTex) {
  final theme = Theme.of(context);
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceSmall,
        model.searchedRecipes!.isNotEmpty
            ? Container()
            : const Text('no result found'),
        verticalSpaceSmall,
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: horizontalViewPading,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2),
              itemCount: model.searchedRecipes!.length,
              itemBuilder: (BuildContext ctx, index) {
                return CreationAwareListItem(
                  itemCreated: () {
                    SchedulerBinding.instance.addPostFrameCallback((duration) =>
                        model.handlesearchPagenation(
                            index, searchRecipeTex!.text));
                  },
                  child: model.searchedRecipes![index].carbs == '^'
                      ? const Center(child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () => model.navigateToRecipeDetils(
                              model.searchedRecipes![index]),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      model.searchedRecipes![index].image!,
                                  fit: BoxFit.cover,
                                ),
                                verticalSpaceTiny,
                                Expanded(
                                  child: Text(
                                    model.searchedRecipes![index].title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: theme.textTheme.bodyText2,
                                  ),
                                ),
                              ]),
                        ),
                );
              }),
        ),
        if (model.isLoading)
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const CircularProgressIndicator())
      ],
    ),
  );
}

recipesBody(RecipesViewModel model, BuildContext context) {
  final theme = Theme.of(context);
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceRegular,
        Text('Sorted By ${recipeSortByToString[model.sortBy]}',
            style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary)),
        verticalSpaceRegular,
        Expanded(
          child: GridView.builder(
              // to maintain the listview position
              key: const PageStorageKey('storage-key'),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: horizontalViewPading,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2),
              itemCount: model.recipesLis!.length,
              itemBuilder: (BuildContext ctx, index) {
                return CreationAwareListItem(
                  itemCreated: () {
                    SchedulerBinding.instance.addPostFrameCallback(
                        (duration) => model.handlePagenation(index));
                  },
                  child: model.recipesLis![index].carbs == '^'
                      ? const Center(child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () => model
                              .navigateToRecipeDetils(model.recipesLis![index]),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: model.recipesLis![index].image!,
                                  fit: BoxFit.cover,
                                ),
                                verticalSpaceTiny,
                                Expanded(
                                  child: Text(
                                    model.recipesLis![index].title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: theme.textTheme.bodyText2,
                                  ),
                                ),
                              ]),
                        ),
                );
              }),
        ),
        if (model.isLoading)
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const CircularProgressIndicator())
      ],
    ),
  );
}
