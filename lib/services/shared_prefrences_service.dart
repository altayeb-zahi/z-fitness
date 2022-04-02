
import 'package:shared_preferences/shared_preferences.dart';

import '../app/logger.dart';
import '../constants/shared_prefrences_constants.dart';
import '../models/recipes_models/recipe_filters_settings.dart';

class SharedPreferencesService {
  Future saveRecipesFiltersSettings(
      RecipeFiltersSettings recipeFiltersSettings) async {
   
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // convert it to string
      String encodedSettings = recipeFiltersSettings.toJson();
      prefs.setString(recipeFiltersSettingsKey, encodedSettings);
    } catch (e) {
      log.e('couldt saveRecipesFiltersSettings $e');
    }
  }

  Future getRecipesFiltersSettings() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? encodedSettings = prefs.getString(recipeFiltersSettingsKey);
      if (encodedSettings == null) return null;
      //convert it back to RecipeFiltersSettings
      RecipeFiltersSettings recipeFiltersSettings =
          RecipeFiltersSettings.fromJson(encodedSettings);
      return recipeFiltersSettings;
    } catch (e) {
      log.e('couldt getRecipesFiltersSettings $e');
    }
  }
}