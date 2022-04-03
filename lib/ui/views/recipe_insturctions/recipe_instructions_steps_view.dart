
import '../../../api/recipes_api.dart';
import '../../../app/locator.dart';
import '../../../models/recipes_models/recipe_steps.dart';
import '../../base/base_view_model.dart';

class RecipeInstructionsViewModel extends BaseViewModel {
  final RecipesApi? _recipesApiService = locator<RecipesApi>();

  List<RecipeStepsModel>? _recipeSteps;
  List<RecipeStepsModel>? get recipeSteps => _recipeSteps;
  
  Future getRecipeSteps(int? id) async {
    setBusy(true);
    var _result = await _recipesApiService!.getRecipeSteps(
      id: id,
      stepBreakdown: true,
    );
    setBusy(false);
    if (_result is List<RecipeStepsModel>) {
      _recipeSteps = _result;

      notifyListeners();
    }
  }
}