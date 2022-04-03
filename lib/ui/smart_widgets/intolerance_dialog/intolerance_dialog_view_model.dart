import '../../../app/locator.dart';
import '../../../constants/recipes_filters_lists.dart';
import '../../../models/recipes_models/recipe_filters_settings.dart';
import '../../../models/recipes_models/recipe_intolerance.dart';
import '../../../services/shared_prefrences_service.dart';
import '../../base/base_view_model.dart';

class IntoleranceDialogViewModel extends BaseViewModel {
  final SharedPreferencesService? _sharedPreferencesService =
      locator<SharedPreferencesService>();

  List<IntoleranceModel>? _intoleranceTypeList;
  List<IntoleranceModel>? get intoleranceTypeList => _intoleranceTypeList;

  Future<void> getIntolercesSettings() async {
    var settingsResult =
        await _sharedPreferencesService!.getRecipesFiltersSettings();

    if (settingsResult is RecipeFiltersSettings) {
      _intoleranceTypeList = settingsResult.intolerances;

      if (settingsResult.intolerances!.isNotEmpty) {
        _intoleranceTypeList = settingsResult.intolerances;
      } else {
        _intoleranceTypeList = defaultIntoleranceTypeList;
      }

    } else {
      _intoleranceTypeList = defaultIntoleranceTypeList;
    }
    notifyListeners();
  }

  void changeValue(IntoleranceModel intoleranceModel) {
    intoleranceModel.isSelected = !intoleranceModel.isSelected!;
    notifyListeners();
  }
}
