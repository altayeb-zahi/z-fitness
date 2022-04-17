import '../models/food_models/food_details.dart';
import '../models/food_models/food_details_dialog_response.dart';

/// Using the serving_weight parameter value from the alt_measure array,
/// you can derive the nutrients in each serving by dividing that serving weight by
/// the default returned serving weight of the food object, and multiplying by the full_nutrients array:
/// (foods.alt_measures.serving_weight / foods.serving_weight_grams) * full_nutrients
NutritientsDetail getUpdatedNutrientsValues(
    DialogResponseData dialogResponseData, Food originalFoodValues) {
  var _originalFoodServingWeight = originalFoodValues.servingWeightGrams!;
  double _newNumberOfServings = dialogResponseData.numberOfServings!;
  double _currentNumberOfServings = originalFoodValues.servingQty!;
  double _alMeasuresServingWeight =
      dialogResponseData.servingWeight ?? _originalFoodServingWeight;

  double num = (_newNumberOfServings / _currentNumberOfServings) *
      (_alMeasuresServingWeight / _originalFoodServingWeight);


  NutritientsDetail _updatedNutrientsDetail = NutritientsDetail(foods: [
    Food(
        foodName: originalFoodValues.foodName,
        photo: originalFoodValues.photo,
        servingQty: _newNumberOfServings,
        servingUnit: dialogResponseData.servingUnit,
        servingWeightGrams: originalFoodValues.servingWeightGrams,
        nfCalories: originalFoodValues.nfCalories! * num,
        nfTotalFat: originalFoodValues.nfTotalFat! * num,
        nfSaturatedFat: originalFoodValues.nfSaturatedFat! * num,
        nfCholesterol: originalFoodValues.nfCholesterol! * num,
        nfSodium: originalFoodValues.nfSodium! * num,
        nfTotalCarbohydrate: originalFoodValues.nfTotalCarbohydrate! * num,
        nfDietaryFiber: originalFoodValues.nfDietaryFiber! * num,
        nfSugars: originalFoodValues.nfSugars! * num,
        nfProtein: originalFoodValues.nfProtein! * num,
        nfPotassium: originalFoodValues.nfPotassium! * num,
        nfP: originalFoodValues.nfP != null
            ? originalFoodValues.nfP! * num
            : null,
        // fullNutrients: _updatedFullNutrients,
        altMeasures: originalFoodValues.altMeasures)
  ]);

  return _updatedNutrientsDetail;
}