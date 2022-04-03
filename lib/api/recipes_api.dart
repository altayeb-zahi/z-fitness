import 'dart:convert';

import 'package:z_fitness/models/recipes_models/recipe_details.dart';

import '../constants/http_constants.dart';
import '../enums/recipes_related_enums.dart';
import '../models/recipes_models/recipe_diet.dart';
import '../models/recipes_models/recipe_intolerance.dart';
import 'package:http/http.dart' as http;

import '../models/recipes_models/recipe_search.dart';
import '../models/recipes_models/recipe_steps.dart';

class RecipesApi {
  Future getCustomRecipesearch(
      {
      // i need to put the '' cuz if its null it wornt bring results
      String searchText = '',
      String? cuisine = '',
      String? diet = '',
      List<IntoleranceModel>? intolerances,
      String? type = '',
      String? sort = '',
      int offset = 0,
      int pageSize = 0}) async {
    String? converetedToOneLineStringIntolerances;

    if (intolerances != null) {
      List<IntoleranceModel> selectedIntolerances =
          await getSelectedIntolerance(intolerances);
       converetedToOneLineStringIntolerances =
          await _convertIntolerancesListToOneString(selectedIntolerances);
    }

    var _response = await http.get(
        Uri.parse(searchRecipeEndPoint +
            'query=$searchText&' +
            'cuisine=$cuisine&' +
            'diet=$diet&' +
            'intolerances=$converetedToOneLineStringIntolerances&' +
            'type=$type&' +
            'sort=$sort&' +
            'offset=$offset&' +
            'number=$pageSize&' +
            'apiKey=$recipesApiKey&'),
        headers: {'Content-Type': 'application/json'});

    if (_response.statusCode == 200) {
      RecipeSearchModel searchedRecipe =
          RecipeSearchModel.fromJson(json.decode(_response.body));
      return searchedRecipe;
    }
    return 'could get the searched recipe';
  }

  getSelectedIntolerance(List<IntoleranceModel> intoleranceTypeList) {
    List<IntoleranceModel> selectedIntoleraces = [];
    for (var element in intoleranceTypeList) {
      if (element.isSelected!) {
        selectedIntoleraces.add(element);
      }
    }

    return selectedIntoleraces;
  }

  Future<String> _convertIntolerancesListToOneString(
      List<IntoleranceModel> intolerances) async {
    if (intolerances.isEmpty) return '';

    List<String?> stringIntoleracesList = [];
    for (var element in intolerances) {
      stringIntoleracesList.add(element.intoleranceType);
    }

    var concatenate = StringBuffer();
    for (var element in stringIntoleracesList) {
      concatenate.write(element! + ',');
    }

    return concatenate.toString();
  }

  Future getDietRecipeSample(
      {required DietType dietType, required int numOfResults}) async {
    var _response = await http.get(
        Uri.parse(searchRecipeEndPoint +
            'number=$numOfResults&' +
            'apiKey=$recipesApiKey&' +
            'sort=random&' +
            'diet=${dietTypeToString[dietType]}'),
        headers: {'Content-Type': 'application/json'});
    if (_response.statusCode == 200) {
      RecipeDietModel dietRecipes =
          RecipeDietModel.fromJson(json.decode(_response.body));
      return dietRecipes;
    }
    return 'could get the dietRecipes';
  }

  Future getRecipesearch(
      {required String searchText, required int numOfResults}) async {
    var _response = await http.get(
        Uri.parse(searchRecipeEndPoint +
            'query=$searchText&' +
            'number=$numOfResults&' +
            'apiKey=$recipesApiKey&'),
        headers: {'Content-Type': 'application/json'});
    if (_response.statusCode == 200) {
      RecipeSearchModel searchedRecipe =
          RecipeSearchModel.fromJson(json.decode(_response.body));
      return searchedRecipe;
    }
    return 'could get the searched recipe';
  }

  Future getRecipeDetails(
      {required int? id, required bool includeNutrition}) async {
    var _response = await http.get(
        Uri.parse(recipeDetailsEndPoint +
            '$id/information?' +
            'includeNutrition=$includeNutrition&' +
            'apiKey=$recipesApiKey'),
        headers: {'Content-Type': 'application/json'});
    if (_response.statusCode == 200) {
      RecipeDetails recipeDetails =
          RecipeDetails.fromMap(json.decode(_response.body));
      return recipeDetails;
    }
    return 'could get recipe details';
  }

  Future getRecipeSteps({required int? id, required bool stepBreakdown}) async {
    var _response = await http.get(
        Uri.parse(recipeStepsEndPoint +
            '$id/analyzedInstructions?' +
            'stepBreakdown=$stepBreakdown&' +
            'apiKey=$recipesApiKey'),
        headers: {'Content-Type': 'application/json'});
    if (_response.statusCode == 200) {
      var steps = (json.decode(_response.body) as List)
          .map((e) => RecipeStepsModel.fromJson(e))
          .toList();

      return steps;
    }
    return 'could get  recipe Steps';
  }
}
