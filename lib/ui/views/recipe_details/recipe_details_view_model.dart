import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/recipes_api.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import '../../../app/locator.dart';
import '../../../enums/dialog_type.dart';
import '../../../managers/food_manager.dart';
import '../../../models/recipes_models/recipe_details.dart';
import '../../../services/database_service.dart';
import '../../base/base_view_model.dart';

class RecipeDetailsViewModel extends BaseViewModel {
  final _recipesApi = locator<RecipesApi>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _databaseService = locator<DatabaseService>();
  final _foodManager = locator<FoodManager>();



  late RecipeDetailsArgument recipeDetailsArgument;

  RecipeDetails? _recipeDetails;
  RecipeDetails? get recipeDetails => _recipeDetails;

  bool _foodIsStoredLocally = true;

  Future<void> onModelReady() async {
    bool _userIsEditingFoodDetails =
        recipeDetailsArgument.userIsEditingNutrition;
    bool _foodDetailsAreComingFromHistory =
        recipeDetailsArgument.userNavigatedFromHistory;

    if (_userIsEditingFoodDetails || _foodDetailsAreComingFromHistory) {
      _recipeDetails = recipeDetailsArgument.recipeDetails!;
      notifyListeners();
    } else {
      setBusy(true);

      final _result = await _databaseService
          .getRecipeNutritionDetails(recipeDetailsArgument.recipeId);

      setBusy(false);

      _foodIsStoredLocally = _result != null;

      if (_foodIsStoredLocally) {
        _recipeDetails = _result!.recipeDetails;
        notifyListeners();
      } else {
        _getRecipeDetailsFromApi();
      }
    }
  }

  Future<void> _getRecipeDetailsFromApi() async {
    setBusy(true);

    var _recipeDetailsResult = await _recipesApi.getRecipeDetails(
        id: recipeDetailsArgument.recipeId, includeNutrition: true);

    setBusy(false);

    if (_recipeDetailsResult is RecipeDetails) {
      _recipeDetails = _recipeDetailsResult;
      notifyListeners();
    }
  }

  Future<void> selectMealType() async {
    var confirmationResponse = await (_dialogService.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.recipeMealType,
    ));

    if (confirmationResponse!.data != null &&
        confirmationResponse.data is MealType) {
      _addRecipeToDailyFoodConcusmed(confirmationResponse.data);
    }
  }

  Future<void> _addRecipeToDailyFoodConcusmed(MealType mealType) async {
     final _foodConsumed = FoodConsumed(
        recipeApiId: recipeDetailsArgument.recipeId,
        foodType: FoodType.recipe,
        mealType:mealType,
        calories: _recipeDetails!.recipeToNutrients!.calories.toDouble(),
        foodConsumed: _recipeDetails!.toJson(),
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),

        );


    await _foodManager.addFoodToDiary(
        _foodConsumed);

    //TODO handle the execption
    _navigationService.popUntil((route) => route.isFirst);
  }

  void navigateToRecipeStepsInstructions(int? id) {
    _navigationService.navigateTo(Routes.recipeInstructionsView, arguments: id);
  }
}
