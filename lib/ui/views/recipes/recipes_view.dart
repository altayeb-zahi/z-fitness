import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/views/recipes/recipes_view_model.dart';

import '../../../enums/recipes_related_enums.dart';
import '../../dumb_widgets/creation_aware_list_items.dart';
import '../../shared/styles.dart';
import '../../shared/ui_helpers.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  final model = RecipesViewModel();
   final  _searchRecipeTex = TextEditingController();

  @override
  void initState() {
    model.initialiseRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<RecipesViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Recipes',style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                GestureDetector(
                    onTap: () => model.showBottomSheet(),
                    child: const Icon(Icons.tune_outlined,color: Colors.purple,)),
                const SizedBox(width: 15)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
        height: screenHeightPercentage(context, percentage: 0.08),
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
              fillColor: Colors.grey[300],
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            )));
  }

  title(RecipesViewModel model) {
    return Column(
      children: const [
        Text(
          'Personalized Recipe Recommendations and Search',
          style: kMediumBlackTitleText,
        ),
        verticalSpaceMedium,
      ],
    );
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
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
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
        ],
      ),
    );
  }

  recipesBody(RecipesViewModel model, BuildContext context) {
    // var theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Text(
            'Sorted By: ${recipeSortByToString[model.sortBy]}',
            // style: theme.textTheme.headline1,
          ),
          verticalSpaceSmall,
          Expanded(
            child: GridView.builder(
                // to maintain the listview position
                key: const PageStorageKey('storage-key'),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 2),
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
                                      width: 200,
                                      height: 130,
                                      fit: BoxFit.fill,
                                    ),
                                    verticalSpaceTiny,
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        model.recipesLis![index].title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        // style: theme.textTheme.bodyText1,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
