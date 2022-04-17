import 'package:intl/intl.dart';
import 'package:z_fitness/models/calories_details.dart';

import '../app/logger.dart';
import '../enums/calories_related_enums.dart';
import '../models/user.dart';
import '../utils/helpers.dart';

class CaloriesService {
  CaloriesDetails _caloriesDetails = CaloriesDetails();
  CaloriesDetails get caloriesDetails => _caloriesDetails;

  double _dailyCaloriesGoal = 0;
  double get dailyCaloriesGoal => _dailyCaloriesGoal;

  double _bmr = 0;
  double get bmr => _bmr;

  int _age = 0;
  int get age => _age;

  ActivityLevel? _activityLevel;
  ActivityLevel? get activityLevel => _activityLevel;

  Future syncCaloriesGoal(User? currentUser) async {
    log.i('caloriesService - syncCaloriesGoal');

    var gender = convertStringToEnum(Gender.values, currentUser!.gender!);

    _activityLevel =
        convertStringToEnum(ActivityLevel.values, currentUser.activityLevel!);

    _age = await _getUserAge(dateOfBirth: currentUser.dateOfBirth!);

    _bmr = await _getBMR(
        currentUser.height!, currentUser.currentWeight!, _age, gender);

    var _caloriesToMaintaint =
        await _getCaloriesToMaintain(_activityLevel!, _bmr);

    var _userGoal = await getUserGoal(
        currentUser.desiredWeight!, currentUser.currentWeight!);

    await _setDailyCaloriesGoal(_userGoal, _caloriesToMaintaint);

    log.v(
        'synced Calories Goal, dailyCaloriesGoal: $dailyCaloriesGoal, age:$age , bmr:$bmr');
  }

  Future _getBMR(int height, int currentWeight, int age, Gender gender) async {
    switch (gender) {
      case Gender.male:
        return (10 * currentWeight) + (6.25 * height) - (5 * age) + 5;
      case Gender.female:
        return (10 * currentWeight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  Future _getCaloriesToMaintain(ActivityLevel activityLevel, double bmr) async {
    switch (activityLevel) {
      case ActivityLevel.notActive:
        return bmr * 1.2;
      case ActivityLevel.lightlyActive:
        return bmr * 1.375;
      case ActivityLevel.active:
        return bmr * 1.725;
      case ActivityLevel.veryActive:
        return bmr * 1.9;
    }
  }

  Future getUserGoal(int desiredWeight, int currentWeight) async {
    if (desiredWeight == currentWeight) return UserGoal.maintainWeight;
    if (desiredWeight > currentWeight) return UserGoal.gainWeight;
    if (desiredWeight < currentWeight) return UserGoal.loseWeight;
  }

  _setDailyCaloriesGoal(userGoal, caloriesToMaintaint) {
    switch (userGoal) {
      case UserGoal.maintainWeight:
        _dailyCaloriesGoal = caloriesToMaintaint;
        break;
      case UserGoal.gainWeight:
        _dailyCaloriesGoal = caloriesToMaintaint + 300;
        break;
      case UserGoal.loseWeight:
        _dailyCaloriesGoal = caloriesToMaintaint - 500;
        break;
    }
  }

  _getUserAge({required String dateOfBirth}) {
    String _datePattern = "dd-MM-yyyy";
    DateTime _birthDate = DateFormat(_datePattern).parse(dateOfBirth);
    DateTime _today = DateTime.now();
    int _yearDiff = _today.year - _birthDate.year;
    return _yearDiff;
  }

  void setCaloriesDetails(CaloriesDetails caloriesDetails) {
    _caloriesDetails = caloriesDetails;
  }
}
