import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:z_fitness/enums/food_type.dart';

import '../../../models/food_models/food_search.dart';

class SearchedFoodListView extends StatelessWidget {
  final List<dynamic> searchedFood;
  final void Function(FoodType foodType, String selectedFoodId) onFoodPressed;

  const SearchedFoodListView(
      {Key? key, required this.searchedFood, required this.onFoodPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: searchedFood.length,
          itemBuilder: (context, index) {
            // Branded food title
            if (searchedFood[index] is String) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Branded',
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: theme.colorScheme.secondary)),
                trailing: const Icon(
                  Icons.verified,
                  color: Colors.green,
                ),
              );
            }

            if (searchedFood[index] is int) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Common',
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: theme.colorScheme.secondary),
                ),
                trailing: const Icon(
                  Icons.verified,
                  color: Colors.grey,
                ),
              );
            }

            // branded food
            if (searchedFood[index] is Branded) {
              return GestureDetector(
                onTap: () => onFoodPressed(
                    FoodType.brandedFood, searchedFood[index].nixItemId),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: searchedFood[index].photo.thumb,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      searchedFood[index].foodName ?? '',
                    ),
                    subtitle: Text(searchedFood[index].servingQty.toString() +
                        " " +
                        searchedFood[index].servingUnit.toString()),
                    trailing: Text(
                        searchedFood[index].nfCalories.round().toString(),
                        style: theme.textTheme.caption),
                  ),
                ),
              );
            }

            // common food (not branded)
            return GestureDetector(
              onTap: () => onFoodPressed(
                  FoodType.commonFood, searchedFood[index].foodName),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: searchedFood[index].photo.thumb,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    searchedFood[index].foodName ?? '',
                  ),
                  subtitle: Text(
                    searchedFood[index].servingQty.toString() +
                        " " +
                        searchedFood[index].servingUnit.toString(),
                  ),
                  //trailing: Text(model.food.common[index].nfCalories.round().toString()),
                ),
              ),
            );
          }),
    );
  }
}
