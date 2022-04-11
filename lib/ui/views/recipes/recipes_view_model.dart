import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

import '../../../api/recipes_api.dart';
import '../../../app/locator.dart';
import '../../../enums/bottom_sheet_type.dart';
import '../../../enums/recipes_related_enums.dart';
import '../../../models/recipes_models/recipe_filters_settings.dart';
import '../../../models/recipes_models/recipe_intolerance.dart';
import '../../../models/recipes_models/recipe_search.dart';
import '../../../services/shared_prefrences_service.dart';
import '../../../utils/recipes_convert_string_to_enum.dart';

class RecipesViewModel extends BaseViewModel {
  final _recipesApi = locator<RecipesApi>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _preferencesService = locator<SharedPreferencesService>();

  RecipeMealType _mealType = RecipeMealType.all;
  RecipeMealType get mealType => _mealType;

  CuisineType _cuisine = CuisineType.all;
  CuisineType get cuisine => _cuisine;

  DietType _diet = DietType.all;
  DietType get diet => _diet;

  RecipeSortBy _sortBy = RecipeSortBy.popularity;
  RecipeSortBy get sortBy => _sortBy;

  List<IntoleranceModel>? _intolerances = <IntoleranceModel>[];
  List<IntoleranceModel>? get intolerances => _intolerances;

  List<RecipeResult>? _recipesList = [];
  List<RecipeResult>? get recipesLis => _recipesList;

  List<RecipeResult>? _searchedRecipes = [];
  List<RecipeResult>? get searchedRecipes => _searchedRecipes;

  static const int pageSize = 14;

  int _offset = 0;
  int _searchOffset = 0;

  int _currentPage = 1;
  int _searchCurrentPage = 1;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool loadingState) {
    _isLoading = loadingState;
    notifyListeners();
  }

  Future initialiseRecipes() async {
    var recipesSettingsResult =
        await _preferencesService.getRecipesFiltersSettings();
    if (recipesSettingsResult is RecipeFiltersSettings) {
      _setRecipesFiltersSetttingsValues(recipesSettingsResult);
    }

    getRecipes();
  }

  Future getRecipes({String? searchTex}) async {
    setBusy(true);
    var _result = await _recipesApi.getCustomRecipesearch(
        searchText: searchTex ?? '',
        cuisine:
            _cuisine == CuisineType.all ? '' : cuisineTypeToString[_cuisine],
        diet: _diet == DietType.all ? '' : dietTypeToString[_diet],
        intolerances: _intolerances!,
        type: _mealType == RecipeMealType.all
            ? ''
            : recipeMealTypeToString[_mealType],
        sort: recipeSortByToString[_sortBy],
        offset: searchTex == null ? _offset : _searchOffset,
        pageSize: pageSize);
    setBusy(false);
    if (_result is RecipeSearchModel) {
      if (searchTex == null) {
        _offset = 0;
        _recipesList = _result.results;
      } else {
        _searchOffset = 0;
        _searchedRecipes = _result.results;
      }
      notifyListeners();
    }
  }

  Future handlePagenation(int index) async {
    var itemPosition = index + 1;
    var requestMoreData = itemPosition % pageSize == 0 && itemPosition != 0;
    var pageToRequest = (itemPosition ~/ pageSize) + 1;

    if (requestMoreData && pageToRequest > _currentPage) {
      _offset = _offset + pageSize;
      _currentPage = pageToRequest;

      setLoading(true);

      await _getMoreRecipes();

      setLoading(false);
    }
  }

  Future handlesearchPagenation(int index, String searchText) async {
    var itemPosition = index + 1;
    var requestMoreData = itemPosition % pageSize == 0 && itemPosition != 0;
    var pageToRequest = (itemPosition ~/ pageSize) + 1;

    if (requestMoreData && pageToRequest > _searchCurrentPage) {
      _searchOffset = _searchOffset + pageSize;
      _searchCurrentPage = pageToRequest;

      setLoading(true);

      await _getMoreRecipes(searchText: searchText);

      setLoading(false);
    }
  }

  Future _getMoreRecipes({String? searchText}) async {
    var _result = await _recipesApi.getCustomRecipesearch(
        searchText: searchText ?? '',
        cuisine:
            _cuisine == CuisineType.all ? '' : cuisineTypeToString[_cuisine],
        diet: _diet == DietType.all ? '' : dietTypeToString[_diet],
        intolerances: _intolerances!,
        type: _mealType == RecipeMealType.all
            ? ''
            : recipeMealTypeToString[_mealType],
        sort: recipeSortByToString[_sortBy],
        offset: searchText != null ? _searchOffset : _offset,
        pageSize: pageSize);

    if (_result is RecipeSearchModel) {
      if (searchText != null) {
        searchedRecipes!.addAll(_result.results!);
      } else {
        _recipesList!.addAll(_result.results!);
      }
    }
  }

  Future showBottomSheet() async {
    var confirmationResponse = await (_bottomSheetService.showCustomSheet(
        variant: BottomSheetType.recipeFilters,
        data: RecipeFiltersSettings(
            recipeMealTypeToString[_mealType],
            cuisineTypeToString[_cuisine],
            dietTypeToString[_diet],
            recipeSortByToString[_sortBy],
            _intolerances)));
    if (confirmationResponse!.data != null &&
        confirmationResponse.data is RecipeFiltersSettings) {
      await updateRecipeFiltersValues(
          confirmationResponse.data as RecipeFiltersSettings);
    }
  }

  Future updateRecipeFiltersValues(RecipeFiltersSettings responseData) async {
    _setRecipesFiltersSetttingsValues(responseData);
    getRecipes();
    _preferencesService.saveRecipesFiltersSettings(responseData);
  }

  void clearSearchedRecipes() {
    _searchedRecipes!.clear();
    notifyListeners();
  }

  void navigateToRecipeDetils(RecipeResult result) {
    final recipeDetailsArgument = RecipeDetailsArgument(recipeId: result.id!);
    _navigationService.navigateTo(Routes.recipeDetailsView, arguments: recipeDetailsArgument);
  }

  void _setRecipesFiltersSetttingsValues(
      RecipeFiltersSettings recipesSettingsResult) {
    _mealType =
        getRecipeMealTypeFromString(recipesSettingsResult.recipeMealType);
    _cuisine = getCuisineTypeFromString(recipesSettingsResult.cuisineType);
    _diet = getDietTypeFromString(recipesSettingsResult.dietType);
    _sortBy = getrecipeSortByFromString(recipesSettingsResult.recipeSortBy);
    _intolerances = recipesSettingsResult.intolerances;
    notifyListeners();
  }
}
