
import 'dart:convert';

import 'package:z_fitness/models/recipes_models/recipe_intolerance.dart';

class RecipeFiltersSettings {
  final String? recipeMealType;
  final String? cuisineType;
  final String? dietType;
  final String? recipeSortBy;
  final List<IntoleranceModel>? intolerances;

  RecipeFiltersSettings(
    this.recipeMealType,
    this.cuisineType,
    this.dietType,
    this.recipeSortBy,
    this.intolerances,
  );

  Map<String, dynamic> toMap() {
    return {
      'recipeMealType': recipeMealType,
      'cuisineType': cuisineType,
      'dietType': dietType,
      'recipeSortBy': recipeSortBy,
      'intolerances': intolerances?.map((x) => x.toMap()).toList(),
    };
  }

  factory RecipeFiltersSettings.fromMap(Map<String, dynamic> map) {
    return RecipeFiltersSettings(
      map['recipeMealType'],
      map['cuisineType'],
      map['dietType'],
      map['recipeSortBy'],
      List<IntoleranceModel>.from(
          map['intolerances']?.map((x) => IntoleranceModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeFiltersSettings.fromJson(String source) =>
      RecipeFiltersSettings.fromMap(json.decode(source));
}