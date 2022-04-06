import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/api/firestore_api.dart';
import 'package:z_fitness/api/food_api.dart';
import 'package:z_fitness/app/locator.dart';
import 'package:z_fitness/enums/food_type.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';

import '../../../app/logger.dart';
import '../../../enums/dialog_type.dart';
import '../../../models/food_models/food_details.dart';
import '../../../models/food_models/food_details_dialog_custom_data.dart';
import '../../../models/food_models/food_details_dialog_response.dart';
import '../../../services/user_service.dart';
import '../../../utils/calculate_food_serving_values.dart';

class FoodDetailsViewModel extends BaseViewModel {
  final _foodApi = locator<FoodApi>();
  final _dialogService = locator<DialogService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _currentUser = locator<UserService>().currentUser;
  final _navigationService = locator<NavigationService>();

  NutritientsDetail? _nutritientsDetail;
  NutritientsDetail? get nutritienstDetail => _nutritientsDetail;

  /// to store the original food values to calculate any serving size or measure type
  late NutritientsDetail _originalNutrientsDetail;

  late FoodDetailsArgument foodDetailsArgument;

  void onModelReady() {
    if (foodDetailsArgument.nutritientsDetail == null) {
      _getFoodDetailsFromApi();
    } else {
      _nutritientsDetail = foodDetailsArgument.nutritientsDetail!;
      _originalNutrientsDetail = foodDetailsArgument.nutritientsDetail!;
      notifyListeners();
    }
  }

  Future _getFoodDetailsFromApi() async {
    setBusy(true);

    switch (foodDetailsArgument.foodType) {
      case FoodType.brandedFood:
        await _foodApi
            .getNutritionDetailsForBrandedFood(
                selectedFoodId: foodDetailsArgument.selectedFoodId!)
            .then((nutritionResult) => _handleNutritionResult(nutritionResult));
        break;
      case FoodType.commonFood:
        await _foodApi
            .getNutritionDetailsForCommonFood(
                selectedFoodId: foodDetailsArgument.selectedFoodId!)
            .then((nutritionResult) => _handleNutritionResult(nutritionResult));
        break;
      default:
    }

    setBusy(false);
  }

  Future addFoodToDatabase() async {
    await _firestoreApi.addFoodConsumed(
        userId: _currentUser!.id!,
        foodConsumed: FoodConsumed(
            foodType: foodDetailsArgument.foodType,
            mealType: foodDetailsArgument.mealType ,
            calories: _nutritientsDetail!.foods![0]!.nfCalories!,
            foodConsumed: nutritientsDetailsToJson(_nutritientsDetail!)),
        date: foodDetailsArgument.date,
        mealType: mealTypeToString[foodDetailsArgument.mealType]!);

    //TODO handle exeption
    _navigationService.popUntil((route) => route.isFirst);
  }

  Future setNumberOfServing() async {
    var _foodDetails = _nutritientsDetail!.foods![0]!;
    var _response = await _showServingsDialog(_foodDetails);

    if (_response?.data != null && _response?.data is DialogResponseData) {
      _updateNutrientsValues(_response?.data);
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

  void _handleNutritionResult(nutritionResult) {
    if (nutritionResult is String) {
      //TODO handle the exeption
      log.e('error to get nutrition details');
    }

    if (nutritionResult is NutritientsDetail) {
      _nutritientsDetail = nutritionResult;
      _originalNutrientsDetail = nutritionResult;
      notifyListeners();
    }
  }

  void _updateNutrientsValues(DialogResponseData dialogResponseData) {
    _nutritientsDetail = getUpdatedNutrientsValues(
        dialogResponseData, _originalNutrientsDetail.foods![0]!);
    notifyListeners();
  }
}
