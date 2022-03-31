import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/app/router.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/food_consumed.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

import '../../../app/locator.dart';
import '../../../models/food_search.dart';

class AddFoodViewModel extends BaseViewModel {
  final _foodApi = locator<FoodApi>();
  final _navigationService = locator<NavigationService>();

  final List<FoodConsumed> _foodHistory = [];
  List<FoodConsumed> get foodHistory => _foodHistory;

  final List<dynamic> _searchedFood = [];
  List<dynamic> get searchedFood => _searchedFood;

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

  void clearSearchResult() {
    _searchedFood.clear();
    notifyListeners();
  }

  navigateToFoodDetails(FoodDetailsArgument foodDetailsArgument) {
    _navigationService.navigateTo(Routes.foodDetailsView,
        arguments: foodDetailsArgument);
  }
}
