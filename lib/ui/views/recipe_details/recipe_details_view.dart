import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:z_fitness/ui/views/recipe_details/recipe_details_view_model.dart';

import '../../../models/recipes_models/recipe_search.dart';
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
        builder: (context, model, child) => WillPopScope(
          onWillPop: model.navigateBack(),
          child: Scaffold(
            body: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        delegate: CustomSliverAppBarDelegate(
                            expandedHeight: 200, model: model),
                        pinned: true,
                      ),
                      detailsBody(model, context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  detailsBody(RecipeDetailsViewModel model, BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          verticalSpaceSmall,
          floating(model, context),
          verticalSpaceSmall,
          diets(model, context),
          verticalSpaceSmall,
          caloriesProtienCarbFat(model, context),
          verticalSpaceSmall,
          tabBar(model, context)
        ],
      ),
    );
  }

  diets(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return model.recipeDetailsModel!.diets!.isEmpty
        ? Container()
        : Container(
            margin: const EdgeInsets.only(left: 30),
            alignment: Alignment.centerLeft,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: theme.backgroundColor,
                        ),
                        margin: const EdgeInsets.all(5),
                        child: Text(
                          model.recipeDetailsModel!.diets![index],
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                    itemCount: model.recipeDetailsModel!.diets!.length,
                  ),
                ),
              ],
            ),
          );
  }

  caloriesProtienCarbFat(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: theme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Text('calories', style: theme.textTheme.bodyText1),
                verticalSpaceSmall,
                Text('${model.calories.toString()} kcal',
                    style: theme.textTheme.headline2),
                const Text('')
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'protien',
                  style: theme.textTheme.bodyText1,
                ),
                verticalSpaceSmall,
                Text(
                    model.recipeDetailsModel!.nutrition!.caloricBreakdown!
                            .percentProtein!
                            .round()
                            .toString() +
                        ' %',
                    style: theme.textTheme.bodyText2),
                Text(model.protein.toString() + ' g',
                    style: theme.textTheme.bodyText1)
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('carb', style: theme.textTheme.bodyText1),
                verticalSpaceSmall,
                Text(
                    model.recipeDetailsModel!.nutrition!.caloricBreakdown!
                            .percentCarbs!
                            .round()
                            .toString() +
                        ' %',
                    style: theme.textTheme.bodyText2),
                Text(model.carb.toString() + ' g',
                    style: theme.textTheme.bodyText1)
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('fat', style: theme.textTheme.bodyText1),
                verticalSpaceSmall,
                Text(
                    model.recipeDetailsModel!.nutrition!.caloricBreakdown!
                            .percentFat!
                            .round()
                            .toString() +
                        ' %',
                    style: theme.textTheme.bodyText2),
                Text(model.fat.toString() + ' g',
                    style: theme.textTheme.bodyText1)
              ],
            ),
          ),
        ],
      ),
    );
  }

  tabBar(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      height: 1000,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: AppBar(
              backgroundColor: theme.backgroundColor,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(
                    indicatorColor: theme.accentColor,
                    unselectedLabelColor: theme.accentColor,
                    labelColor: theme.textTheme.bodyText1!.color,
                    tabs: const [
                      Tab(
                        text: 'ingredients',
                      ),
                      Tab(
                        text: 'nutrients',
                      ),
                      Tab(
                        text: 'prices',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TabBarView(
              children: [
                showIngredients(model, context),
                showNutrients(model, context),
                showPrices(model, context)
              ],
            ),
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
        var ingredient = model.recipeDetailsModel!.extendedIngredients![index];
        return Container(
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              border: Border.all(color: theme.scaffoldBackgroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          margin: const EdgeInsets.all(3),
          child: ListTile(
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
            title: Text(ingredient.name!, style: theme.textTheme.bodyText1),
            subtitle: Text(
                ingredient.amount!.toStringAsFixed(2) +
                    ' ' +
                    ingredient.measures!.metric!.unitShort!,
                style: theme.textTheme.bodyText2),
          ),
        );
      },
      itemCount: model.recipeDetailsModel!.extendedIngredients!.length,
    );
  }

  showNutrients(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            color: theme.backgroundColor,
            border: Border.all(color: theme.scaffoldBackgroundColor),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        margin: const EdgeInsets.all(3),
        child: ListTile(
          title: Text(
              model.recipeDetailsModel!.nutrition!.nutrients![index].name!,
              style: theme.textTheme.bodyText1),
          trailing: Text(
              model.recipeDetailsModel!.nutrition!.nutrients![index].amount
                  .toString(),
              style: theme.textTheme.bodyText2),
        ),
      ),
      itemCount: model.recipeDetailsModel!.extendedIngredients!.length,
    );
  }

  showPrices(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            color: theme.backgroundColor,
            border: Border.all(color: theme.scaffoldBackgroundColor),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        margin: const EdgeInsets.all(3),
        child: ListTile(
          title: Text(
            model.recipeDetailsModel!.extendedIngredients![index].name!,
            style: theme.textTheme.bodyText1,
          ),
        ),
      ),
      itemCount: model.recipeDetailsModel!.extendedIngredients!.length,
    );
  }

  floating(RecipeDetailsViewModel model, BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: theme.backgroundColor,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(children: [
          const Icon(Icons.add_alarm_outlined),
          verticalSpaceSmall,
          Text(
            model.recipeDetailsModel!.readyInMinutes.toString() + ' min',
            style: theme.textTheme.bodyText2,
          )
        ]),
        Column(children: [
          const Icon(Icons.favorite_border_outlined),
          verticalSpaceSmall,
          Text(
            model.recipeDetailsModel!.spoonacularScore.toString(),
            style: theme.textTheme.bodyText2,
          )
        ]),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => model
              .navigateToRecipeStepsInstructions(model.recipeDetailsModel!.id),
          child: Column(children: [
            const Icon(Icons.kitchen_outlined),
            verticalSpaceSmall,
            Text(
              'start cocking',
              style: theme.textTheme.bodyText2,
            )
          ]),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => model.showMealTypeDialog(),
          child: Column(children: [
            const Icon(Icons.add),
            verticalSpaceSmall,
            Text(
              'add to Diary',
              style: theme.textTheme.bodyText2,
            )
          ]),
        ),
      ]),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final RecipeDetailsViewModel model;

  const CustomSliverAppBarDelegate(
      {required this.expandedHeight, required this.model});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //final size = 60;
    //final top = expandedHeight - shrinkOffset - size / 3;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(shrinkOffset, model),
        buildAppBar(shrinkOffset, model),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset, RecipeDetailsViewModel model) =>
      Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          title: Text(model.recipeDetailsModel!.title ?? ''),
          centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset, RecipeDetailsViewModel model) =>
      Opacity(
        opacity: disappear(shrinkOffset),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: model.recipeDetailsModel!.image!,
        ),
      );

  Widget buildButton({
    required String text,
    required IconData icon,
  }) =>
      TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 20)),
          ],
        ),
        onPressed: () {},
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
