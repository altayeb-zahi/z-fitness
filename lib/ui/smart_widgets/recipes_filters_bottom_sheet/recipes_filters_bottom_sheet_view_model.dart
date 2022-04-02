import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../constants/recipes_filters_lists.dart';
import '../../../enums/dialog_type.dart';
import '../../../enums/recipes_related_enums.dart';
import '../../../models/recipes_models/recipe_filters_settings.dart';
import '../../../models/recipes_models/recipe_intolerance.dart';
import '../../../utils/recipes_convert_string_to_enum.dart';
import '../../base/base_view_model.dart';

class RecipeBottomSheetModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  RecipeMealType? _mealType;
  RecipeMealType? get mealType => _mealType;

  CuisineType? _cuisine;
  CuisineType? get cuisine => _cuisine;

  DietType? _diet = DietType.all;
  DietType? get diet => _diet;

  List<IntoleranceModel>? _intolerances = <IntoleranceModel>[];
  List<IntoleranceModel>? get intolerances => _intolerances;

  RecipeSortBy? _sortBy;
  RecipeSortBy? get sortBy => _sortBy;

   final List<RecipeMealType> _mealTypesList = recipeMealTypesList;
  List<RecipeMealType> get mealTypesList => _mealTypesList;

  final List<CuisineType> _cuisinesTypeList = cuisineTypesList;
  List<CuisineType> get cuisinesTypeList => _cuisinesTypeList;

  final List<DietType> _dietTypeList = dietsTypesList;
  List<DietType> get dietTypesList => _dietTypeList;

  final List<RecipeSortBy> _sortByList = recipeSortByList;
  List<RecipeSortBy> get sortByList => _sortByList;

  void setMealType(RecipeMealType? recipeMealType) {
    _mealType = recipeMealType;
    notifyListeners();
  }

  void setCuisineType(CuisineType? cuisineType) {
    _cuisine = cuisineType;
    notifyListeners();
  }

  void setDietType(DietType? dietType) {
    _diet = dietType;
    notifyListeners();
  }

  void setIntoleranceTypes(List<IntoleranceModel> intoleranceTypes) {
    _intolerances = intoleranceTypes;
    notifyListeners();
  }

  void setRecipeSortBy(RecipeSortBy? sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  initilizeFiltersValues(RecipeFiltersSettings customData) {
    _mealType = getRecipeMealTypeFromString(customData.recipeMealType);
    _cuisine = getCuisineTypeFromString(customData.cuisineType);
    _diet = getDietTypeFromString(customData.dietType);
    _sortBy = getrecipeSortByFromString(customData.recipeSortBy);
    _intolerances = customData.intolerances;
  }

  Future showIntoleranceDialog() async {
    var confirmationResponse = await _dialogService.showCustomDialog(
      variant: DialogType.intolerance,
    );

    if (confirmationResponse!.responseData != null &&
        confirmationResponse.responseData is List<IntoleranceModel>) {
      _intolerances = confirmationResponse.responseData;
    }
  }
}