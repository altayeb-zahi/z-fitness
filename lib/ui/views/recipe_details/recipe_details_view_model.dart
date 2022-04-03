import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/firestore_api.dart';
import 'package:z_fitness/api/recipes_api.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import '../../../app/locator.dart';
import '../../../enums/dialog_type.dart';
import '../../../models/recipes_models/recipe_details.dart';
import '../../../services/user_service.dart';
import '../../base/base_view_model.dart';

class RecipeDetailsViewModel extends BaseViewModel {
  final _recipesApi = locator<RecipesApi>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _currentUser = locator<UserService>().currentUser;

  RecipeDetails? _recipeDetails;
  RecipeDetails? get recipeDetails => _recipeDetails;

  Future<void> getRecipeDetails(int? id) async {
    setBusy(true);

    var _recipeDetailsResult =
        await _recipesApi.getRecipeDetails(id: id, includeNutrition: true);

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
        confirmationResponse.data is String) {
      _addRecipeToDailyFoodConcusmed(confirmationResponse.data);
    }
  }

  Future<void> _addRecipeToDailyFoodConcusmed(String mealType) async {
    await _firestoreApi.addFoodConsumed(
        userId: _currentUser!.id!,
        foodConsumed: FoodConsumed(
            foodType: foodTypeToString[FoodType.recipe]!,
            calories: _recipeDetails!.recipeToNutrients!.calories.toDouble(),
            foodConsumed: _recipeDetails!.toJson()),
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        meal: mealType);

    //TODO handle the execption
    _navigationService.popUntil((route) => route.isFirst);
  }

  void navigateToRecipeStepsInstructions(int? id) {
    _navigationService.navigateTo(Routes.recipeInstructionsView, arguments: id);
  }
}
