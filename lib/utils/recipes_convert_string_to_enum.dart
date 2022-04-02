
import '../enums/recipes_related_enums.dart';

T convertToEnum<T>(List<T> values, String value) {
  return values.firstWhere((e) => e.toString() == value);
}

// ignore: todo
//TODO convert the 4 functions below to one genaric function

RecipeMealType getRecipeMealTypeFromString(String? recipeMealType) {
  recipeMealType = 'RecipeMealType.$recipeMealType';
  return RecipeMealType.values.firstWhere((f) => f.toString() == recipeMealType,
      orElse: () => RecipeMealType.all);
}

CuisineType getCuisineTypeFromString(String? cuisineType) {
  cuisineType = 'CuisineType.$cuisineType';
  return CuisineType.values.firstWhere((f) => f.toString() == cuisineType,
      orElse: () => CuisineType.all);
}

DietType getDietTypeFromString(String? dietType) {
  dietType = 'DietType.$dietType';
  return DietType.values
      .firstWhere((f) => f.toString() == dietType, orElse: () => DietType.all);
}

RecipeSortBy getrecipeSortByFromString(String? recipeSortBy) {
  recipeSortBy = 'RecipeSortBy.$recipeSortBy';
  return RecipeSortBy.values.firstWhere((f) => f.toString() == recipeSortBy,
      orElse: () => RecipeSortBy.popularity);
}