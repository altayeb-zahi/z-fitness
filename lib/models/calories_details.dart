import 'dart:convert';

class CaloriesDetails {
   int dailyCaloriesGoal;
  final int totalCaloriesConsumed;
  final int caloriesBurned;
  final int caloriesRemaining;
  final int totalBreakfastCalories;
  final int totalLunchCalories;
  final int totalDinnerCalories;
  final int totalSnacksCalories;
  final int totalWaterConsumed;


  CaloriesDetails(
      {this.dailyCaloriesGoal = 2500,
      this.totalCaloriesConsumed = 0,
      this.caloriesBurned = 0,
      this.caloriesRemaining = 2500,
      this.totalBreakfastCalories = 0,
      this.totalLunchCalories = 0,
      this.totalDinnerCalories = 0,
      this.totalSnacksCalories = 0,
      this.totalWaterConsumed = 0});

  Map<String, dynamic> toMap() {
    return {
      'dailyCaloriesGoal': dailyCaloriesGoal,
      'totalCaloriesConsumed': totalCaloriesConsumed,
      'caloriesBurned': caloriesBurned,
      'caloriesRemaining': caloriesRemaining,
      'totalBreakfastCalories': totalBreakfastCalories,
      'totalLunchCalories': totalLunchCalories,
      'totalDinnerCalories': totalDinnerCalories,
      'totalSnacksCalories': totalSnacksCalories,
      'totalWaterConsumed': totalWaterConsumed
    };
  }

  factory CaloriesDetails.fromMap(Map<String, dynamic> map) {
    return CaloriesDetails(
      dailyCaloriesGoal: map['dailyCaloriesGoal']?.toInt() ?? 2500,
      totalCaloriesConsumed: map['totalCaloriesConsumed']?.toInt() ?? 0,
      caloriesBurned: map['caloriesBurned']?.toInt() ?? 0,
      caloriesRemaining: map['caloriesRemaining']?.toInt() ?? 2500,
      totalBreakfastCalories: map['totalBreakfastCalories']?.toInt() ?? 0,
      totalLunchCalories: map['totalLunchCalories']?.toInt() ?? 0,
      totalDinnerCalories: map['totalDinnerCalories']?.toInt() ?? 0,
      totalSnacksCalories: map['totalSnacksCalories']?.toInt() ?? 0,
      totalWaterConsumed: map['totalWaterConsumed']?.toInt() ?? 0
    );
  }

  String toJson() => json.encode(toMap());

  factory CaloriesDetails.fromJson(String source) =>
      CaloriesDetails.fromMap(json.decode(source));
}
