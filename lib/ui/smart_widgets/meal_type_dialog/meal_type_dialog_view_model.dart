
import '../../../enums/meal_type.dart';
import '../../base/base_view_model.dart';

class MealTypeDialogViewModel extends BaseViewModel {
  List<MealType> mealTypeList = [
    MealType.breakfast,
    MealType.launch,
    MealType.dinner,
    MealType.snacks
  ];
}