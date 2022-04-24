import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/views/recipes/recipes_view_model.dart';

import '../../../enums/recipes_related_enums.dart';
import '../../dumb_widgets/creation_aware_list_items.dart';
import '../../shared/app_colors.dart';
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
              title:  Text(
                'Recipes',
                style: theme.textTheme.headline3,
              ),
              elevation: 0,
              actions: [
                GestureDetector(
                    onTap: () => model.showBottomSheet(),
                    child: const Icon(
                      Icons.tune_outlined,
                      color: kcPrimaryColor,
                    )),
                const SizedBox(width: 15)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(model, context, _searchRecipeTex),
                  model.isBusy
                      ? const Center(child: CircularProgressIndicator())
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

  searchBar(RecipesViewModel model, BuildContext context,
      TextEditingController? searchRecipeTex) {
    return SizedBox(
        height: 50,
        child: TextField(
            onChanged: (txt) {
              if (txt == '' || txt.isEmpty) {
                model.clearSearchedRecipes();
              }
            },
            controller: searchRecipeTex,
            autocorrect: true,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    if (searchRecipeTex!.text.isNotEmpty &&
                        searchRecipeTex.text.isNotEmpty) {
                      model.getRecipes(searchTex: searchRecipeTex.text);
                    }
                  },
                  child: const Icon(Icons.search)),
              hintText: 'Search Recipes...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: kcBackgroundColor,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: kcBackgroundColor, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: kcBackgroundColor),
              ),
            )));
  }


  searchedRecipesBody(RecipesViewModel model, BuildContext context,
      TextEditingController? searchRecipeTex) {
    // var theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          model.searchedRecipes!.isNotEmpty
              ? Text(
                  ' search results Sorted By: ${recipeSortByToString[model.sortBy]}',
                )
              : const Text('no result found'),
          verticalSpaceSmall,
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: horizontalViewPading,
                    mainAxisSpacing: 0,
                    crossAxisCount: 2),
                itemCount: model.searchedRecipes!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return CreationAwareListItem(
                    itemCreated: () {
                      SchedulerBinding.instance!.addPostFrameCallback(
                          (duration) => model.handlesearchPagenation(
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
                                    width: 200,
                                    height: 130,
                                    fit: BoxFit.fill,
                                  ),
                                  verticalSpaceTiny,
                                  Text(
                                    model.searchedRecipes![index].title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    // style: theme.textTheme.bodyText1,
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
                child: const CircularProgressIndicator(
                  color: Colors.purple,
                ))
        ],
      ),
    );
  }

  recipesBody(RecipesViewModel model, BuildContext context) {
    final theme = Theme.of(context);
    // var theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceRegular,
          Text(
            'Sorted By ${recipeSortByToString[model.sortBy]}',
            style: theme.textTheme.headline3,
          ),
          verticalSpaceRegular,
          Expanded(
            child: GridView.builder(
                // to maintain the listview position
                key: const PageStorageKey('storage-key'),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: horizontalViewPading, mainAxisSpacing: 0, crossAxisCount: 2),
                itemCount: model.recipesLis!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return CreationAwareListItem(
                    itemCreated: () {
                      SchedulerBinding.instance!.addPostFrameCallback(
                          (duration) => model.handlePagenation(index));
                    },
                    child: model.recipesLis![index].carbs == '^'
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: () => model.navigateToRecipeDetils(
                                model.recipesLis![index]),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: model.recipesLis![index].image!,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      model.recipesLis![index].title!,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: theme.textTheme.bodyText2,
                                    ),
                                  ]),
                            ),
                          ),
                  );
                }),
          ),
          if (model.isLoading)
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: const CircularProgressIndicator(
                  color: Colors.purple,
                ))
        ],
      ),
    );
  }
}
