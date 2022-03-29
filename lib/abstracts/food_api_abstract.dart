import '../models/arguments_models.dart';

abstract class FoodApiAbstract {
  Future getSearchedFood({required String searchText});
  
  //TODO i dont like addFoodArgument here i only need foodType and selectedFood(check what is it) and add them as parmmeter instead of addFoodArgument it will make it more easy to know what i need in foodApi
  // and then make the foodApi implement this class
  Future getFoodNutritionDetails(
      {required FoodDetailsArgument addFoodArgument, String? timeZone});
}
