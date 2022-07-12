// ignore_for_file: unused_import

import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/firestore_api.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/managers/food_manager.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/services/database_service.dart';
import 'package:z_fitness/services/diary_service.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';
import '../../../app/logger.dart';
import '../../../enums/dialog_type.dart';
import '../../../models/food_models/food_details.dart';
import '../../../models/food_models/food_details_dialog_custom_data.dart';
import '../../../models/food_models/food_details_dialog_response.dart';
import '../../../services/calories_service.dart';
import '../../../services/user_service.dart';
import '../../../utils/calculate_food_serving_values.dart';

class FoodDetailsViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  final _navigationService = locator<NavigationService>();

  final _foodManager = locator<FoodManager>();

  NutritientsDetail? _nutritientsDetail;

  NutritientsDetail? get nutritienstDetail => _nutritientsDetail;

  late FoodDetailsArgument foodDetailsArgument;

  Future<void> getFoodNutritionDetails() async {
    setBusy(true);
    _nutritientsDetail = await _foodManager.getFoodNutritionDetails(
        foodDetailsArgument: foodDetailsArgument);

    notifyListeners();
    setBusy(false);
  }

  Future onMainButtonPressed() async {
    final _foodConsumed = FoodConsumed(
      foodApiId: foodDetailsArgument.selectedFoodId,
      foodType: foodDetailsArgument.foodType,
      mealType: foodDetailsArgument.mealType,
      calories: _nutritientsDetail!.foods![0]!.nfCalories!,
      databaseId: foodDetailsArgument.databaseId,
      foodConsumed: nutritientsDetailsToJson(
        _nutritientsDetail!,
      ),
      date: foodDetailsArgument.date,
    );

    if (foodDetailsArgument.userIsEditingNutrition) {
      _foodConsumed.nutritientsDetail = _nutritientsDetail;
      await _foodManager.updateFoodInDiary(_foodConsumed);
    } else {
      _foodManager.addFoodToDiary(_foodConsumed);
    }

    _navigationService.popUntil((route) => route.isFirst);
  }

  Future setNumberOfServing() async {
    var _foodDetails = _nutritientsDetail!.foods![0]!;
    var _response = await _showServingsDialog(_foodDetails);

    if (_response?.data != null && _response?.data is DialogResponseData) {
      final dialogResponseData = _response?.data;

      _nutritientsDetail = getUpdatedNutrientsValues(
          dialogResponseData, _nutritientsDetail!.foods![0]!);

      notifyListeners();
    }
  }

  Future _showServingsDialog(Food foodDetails) async {
    return await _dialogService.showCustomDialog(
      variant: DialogType.form,
      title: 'how much?',
      mainButtonTitle: 'save',
      additionalButtonTitle: 'canel',
      data: CustomData(
        numberOfServing: foodDetails.servingQty,
        servingUnit: foodDetails.servingUnit,
        servingWeight: foodDetails.servingWeightGrams,
        allMeasures: foodDetails.altMeasures,
      ),
    );
  }
}
