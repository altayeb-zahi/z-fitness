import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/recipes_api.dart';

import '../../../app/locator.dart';
import '../../../enums/dialog_type.dart';
import '../../../models/recipes_models/recipe_details.dart';
import '../../base/base_view_model.dart';

class RecipeDetailsViewModel extends BaseViewModel {
  final _recipesApi = locator<RecipesApi>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  int? _calories;
  int? get calories => _calories;
  int? _protein;
  int? get protein => _protein;
  int? _carb;
  int? get carb => _carb;
  int? _fat;
  int? get fat => _fat;

  RecipeDetails? _recipeDetailsModel;
  RecipeDetails? get recipeDetailsModel => _recipeDetailsModel;

  Future getRecipeDetails(int? id) async {
    setBusy(true);
    var _result = await _recipesApi.getRecipeDetails(
        id: id, includeNutrition: true);
    setBusy(false);
    if (_result is RecipeDetails) {
      _recipeDetailsModel = _result;
      _result.nutrition!.nutrients!.forEach((element) {
        if (element.name == 'Calories') _calories = element.amount!.round();
        if (element.name == 'Protein') _protein = element.amount!.round();
        if (element.name == 'Carbohydrates') _carb = element.amount!.round();
        if (element.name == 'Fat') _fat = element.amount!.round();
      });
      notifyListeners();
    }
  }

 void navigateToRecipeStepsInstructions(int? id) {
    // _navigationService.navigateTo(Routes.recipeInstructionsStepsView,
    //     arguments: RecipeInstructionsStepsViewArguments(id: id));
  }

  navigateBack() {
    _navigationService.previousRoute;
  }

  Future saveToDatabase(
    // RecipeDatabase recipeDatabase
    ) async {
    // var _result = await _databaseService.saveRecipeToDatabase(recipeDatabase);
    // if (_result is String) {
    //   print('failed to save recipe to database');
    // } else {
    //   await _foodRecipesManager.syncFoodAndRecipes();

    //   _navigationService.pushNamedAndRemoveUntil(Routes.bottomNavigationView);
    // }
  }

  Future showMealTypeDialog() async {
    // var confirmationResponse = await (_dialogService.showCustomDialog(
    //   barrierDismissible: true,
    //   variant: DialogType.recipeMealType,
    // ));

    // if (confirmationResponse!.data != null &&
    //     confirmationResponse.data is String) {
    //   await saveToDatabase(RecipeDatabase(
    //       mealType: confirmationResponse.data,
    //       calories: _calories!,
    //       recipeDetails: recipeDetailsToJson(_recipeDetailsModel!)));
    // }
  }
}