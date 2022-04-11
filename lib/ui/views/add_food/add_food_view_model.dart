import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/firestore_api.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

import '../../../app/locator.dart';
import '../../../enums/food_type.dart';
import '../../../models/food_models/food_search.dart';
import '../../../services/database_service.dart';
import '../../../services/user_service.dart';

class AddFoodViewModel extends BaseViewModel {
  final _foodApi = locator<FoodApi>();
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _currentUser = locator<UserService>().currentUser;

  List<FoodConsumed> _foodHistory = [];
  List<FoodConsumed> get foodHistory => _foodHistory;

  final List<dynamic> _searchedFood = [];
  List<dynamic> get searchedFood => _searchedFood;

  late AddFoodArgument addFoodArgument;

  Future getSearchedFood(String searchText) async {
    setBusy(true);
    var _foodResult = await _foodApi.getSearchedFood(searchText: searchText);
    setBusy(false);
    if (_foodResult is SearchedFood) {
      _searchedFood.clear();
      _searchedFood.add('branded title');
      _searchedFood.addAll(_foodResult.branded!);
      _searchedFood.add(0);
      _searchedFood.addAll(_foodResult.common!);

      notifyListeners();
    } else {
      //TODO  handle the error
    }
  }

  Future<void> getFoodHistory() async {
    final _result = await _databaseService.getFoodHistoryFromDatabase();

    if (_result != null) {
      _foodHistory = _result;
      notifyListeners();
    } else {
      final _result = await _firestoreApi.getFoodHistory(_currentUser!.id!);

      if (_result is List<FoodConsumed>) {
        _foodHistory = _result;
        notifyListeners();
      }
    }
  }

  void clearSearchResult() {
    _searchedFood.clear();
    notifyListeners();
  }

  navigateToFoodDetails(FoodDetailsArgument foodDetailsArgument) {
    _navigationService.navigateTo(Routes.foodDetailsView,
        arguments: foodDetailsArgument);
  }

  void onHistoryItemPressed(FoodConsumed foodConsumed) {
    if (foodTypeToString[foodConsumed.foodType] ==
        foodTypeToString[FoodType.recipe]) {
      _navigationService.navigateTo(Routes.recipeDetailsView,
          arguments: RecipeDetailsArgument(
              recipeDetailsAreComingFromHistory: true,
              date: addFoodArgument.date,
              foodType: foodConsumed.foodType,
              mealType: addFoodArgument.mealType,
              recipeId: foodConsumed.recipeDetails!.id!,
              recipeDetails: foodConsumed.recipeDetails));
    } else {
      _navigationService.navigateTo(Routes.foodDetailsView,
          arguments: FoodDetailsArgument(
              foodDetailsAreComingFromHistory: true,
              date: addFoodArgument.date,
              foodType: foodConsumed.foodType,
              mealType: addFoodArgument.mealType,
              selectedFoodId: foodConsumed.foodApiId,
              nutritientsDetail: foodConsumed.nutritientsDetail,
              ));
    }
  }
}
