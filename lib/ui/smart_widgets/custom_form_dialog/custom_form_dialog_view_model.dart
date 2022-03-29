import '../../../models/food_details.dart';
import '../../../models/food_details_dialog_custom_data.dart';
import '../../base/base_view_model.dart';

class CustomFormDialogViewModel extends BaseViewModel {
  double? _servingQty;
  double? get servingQty => _servingQty;

  String? _servingUnit;
  String? get servingUnit => _servingUnit;

  double? _servingWeight;
  get servingWight => _servingWeight;

  initialiseValues(CustomData customData) {
    _servingUnit = customData.servingUnit;
    //_servingWeight = customData.servingWeight;
    _servingQty = customData.numberOfServing;
    notifyListeners();
  }

  void setValues(AltMeasure altMeasure) {
    _servingWeight = altMeasure.servingWeight;
    _servingUnit = altMeasure.measure;
    _servingQty = altMeasure.qty;
    notifyListeners();
  }
}