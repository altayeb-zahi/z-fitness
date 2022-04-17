import 'dart:convert';

import 'package:z_fitness/models/calories_details.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? profilePic;
  String? token;
  String? gender;
  String? activityLevel;
  String? dateOfBirth;
  int? height;
  int? currentWeight;
  int? desiredWeight;
  double? dailyCaloriesGoal;
  double? bmr;
  int? age;

  CaloriesDetails? caloriesDetails;

  User(
      {this.id,
      this.name,
      this.email,
      this.profilePic,
      this.token,
      this.gender,
      this.activityLevel,
      this.dateOfBirth,
      this.height,
      this.currentWeight,
      this.desiredWeight,
      this.dailyCaloriesGoal,
      this.bmr,
      this.age,
      this.caloriesDetails
      });

  bool get hasWeightInfo => dateOfBirth?.isNotEmpty ?? false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'token': token,
      'gender': gender,
      'activityLevel': activityLevel,
      'dateOfBirth': dateOfBirth,
      'height': height,
      'currentWeight': currentWeight,
      'desiredWeight': desiredWeight,
      'dailyCaloriesGoal': dailyCaloriesGoal,
      'bmr': bmr,
      'age': age,
      'caloriesDetails':caloriesDetails!= null? caloriesDetails!.toMap():null,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      token: map['token'],
      gender: map['gender'],
      activityLevel: map['activityLevel'],
      dateOfBirth: map['dateOfBirth'],
      height: map['height']?.toInt(),
      currentWeight: map['currentWeight']?.toInt(),
      desiredWeight: map['desiredWeight']?.toInt(),
      dailyCaloriesGoal: map['dailyCaloriesGoal']?.toDouble(),
      bmr: map['bmr']?.toDouble(),
      age: map['age']?.toInt(),
      caloriesDetails: map['caloriesDetails'] != null? CaloriesDetails.fromMap(map['caloriesDetails']):null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
