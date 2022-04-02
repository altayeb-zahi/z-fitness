// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

NutritientsDetail nutritientsDetailsFromJson(String str) =>
    NutritientsDetail.fromJson(json.decode(str));

String nutritientsDetailsToJson(NutritientsDetail data) =>
    json.encode(data.toJson());

class NutritientsDetail {
  NutritientsDetail({
    this.foods,
  });

  List<Food?>? foods;

  factory NutritientsDetail.fromJson(Map<String, dynamic> json) =>
      NutritientsDetail(
        foods: json["foods"] == null
            ? null
            : List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods!.map((x) => x!.toJson())),
      };
}

class Food {
  Food({
    this.id,
    this.mealType,
    this.foodType,
    this.foodName,
    this.brandName,
    this.servingQty,
    this.servingUnit,
    this.servingWeightGrams,
    this.nfCalories,
    this.nfTotalFat,
    this.nfSaturatedFat,
    this.nfCholesterol,
    this.nfSodium,
    this.nfTotalCarbohydrate,
    this.nfDietaryFiber,
    this.nfSugars,
    this.nfProtein,
    this.nfPotassium,
    this.nfP,
    this.fullNutrients,
    this.altMeasures,
    this.photo,
  });
  //id for database
  int? id;
  String? mealType;
  String? foodType;
  String? foodName;
  String? brandName;
  double? servingQty;
  String? servingUnit;
  double? servingWeightGrams;
  double? nfCalories;
  double? nfTotalFat;
  double? nfSaturatedFat;
  double? nfCholesterol;
  double? nfSodium;
  double? nfTotalCarbohydrate;
  double? nfDietaryFiber;
  double? nfSugars;
  double? nfProtein;
  double? nfPotassium;
  double? nfP;
  List<FullNutrient>? fullNutrients;
  List<AltMeasure>? altMeasures;
  Photo? photo;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        mealType: json['mealType'],
        id: json["id"],
        foodName: json["food_name"],
        foodType: json['foodType'],
        brandName:
            // ignore: prefer_null_aware_operators
            json["brand_name"] == null ? null : json["brand_name"].toString(),
        servingQty:
            json["serving_qty"] == null ? null : json["serving_qty"].toDouble(),
        servingUnit: json["serving_unit"],
        servingWeightGrams: json["serving_weight_grams"] == null
            ? null
            : json["serving_weight_grams"].toDouble(),
        nfCalories:
            json["nf_calories"] == null ? null : json["nf_calories"].toDouble(),
        nfTotalFat: json["nf_total_fat"] == null
            ? null
            : json["nf_total_fat"].toDouble(),
        nfSaturatedFat: json["nf_saturated_fat"] == null
            ? null
            : json["nf_saturated_fat"].toDouble(),
        nfCholesterol: json["nf_cholesterol"] == null
            ? null
            : json["nf_cholesterol"].toDouble(),
        nfSodium:
            json["nf_sodium"] == null ? null : json["nf_sodium"].toDouble(),
        nfTotalCarbohydrate: json["nf_total_carbohydrate"] == null
            ? null
            : json["nf_total_carbohydrate"].toDouble(),
        nfDietaryFiber: json["nf_dietary_fiber"] == null
            ? null
            : json["nf_dietary_fiber"].toDouble(),
        nfSugars:
            json["nf_sugars"] == null ? null : json["nf_sugars"].toDouble(),
        nfProtein:
            json["nf_protein"] == null ? null : json["nf_protein"].toDouble(),
        nfPotassium: json["nf_potassium"] == null
            ? null
            : json["nf_potassium"].toDouble(),
        nfP: json["nf_p"] == null ? null : json["nf_p"].toDouble(),
        fullNutrients: json["full_nutrients"] == null
            ? null
            : List<FullNutrient>.from(
                json["full_nutrients"].map((x) => FullNutrient.fromJson(x))),
        altMeasures: json["alt_measures"] == null
            ? null
            : List<AltMeasure>.from(
                json["alt_measures"].map((x) => AltMeasure.fromJson(x))),
        photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'mealType': mealType,
        "food_name": foodName,
        'foodType': foodType,
        "brand_name": brandName,
        "serving_qty": servingQty,
        "serving_unit": servingUnit,
        "serving_weight_grams": servingWeightGrams,
        "nf_calories": nfCalories,
        "nf_total_fat": nfTotalFat,
        "nf_saturated_fat": nfSaturatedFat,
        "nf_cholesterol": nfCholesterol,
        "nf_sodium": nfSodium,
        "nf_total_carbohydrate": nfTotalCarbohydrate,
        "nf_dietary_fiber": nfDietaryFiber,
        "nf_sugars": nfSugars,
        "nf_protein": nfProtein,
        "nf_potassium": nfPotassium,
        "nf_p": nfP,
        // "full_nutrients": id != null
        //     ? null
        //     : List<dynamic>.from(fullNutrients.map((x) => x.toJson())),
        // "alt_measures": List<dynamic>.from(altMeasures.map((x) => x.toJson())),
        // "photo": id != null ? null : photo.toJson(),
      };
}

class AltMeasure {
  AltMeasure({
    //id for database
    //foodId for database foreign key
    this.id,
    this.foodId,
    this.servingWeight,
    this.measure,
    this.seq,
    this.qty,
  });

  int? id;
  int? foodId;
  double? servingWeight;
  String? measure;
  double? seq;
  double? qty;

  factory AltMeasure.fromJson(Map<String, dynamic> json) => AltMeasure(
        id: json['id'],
        foodId: json['foodId'],
        servingWeight: json["serving_weight"].toDouble(),
        measure: json["measure"],
        seq: json["seq"] == null ? null : json["seq"].toDouble(),
        qty: json["qty"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'foodId': foodId,
        "serving_weight": servingWeight,
        "measure": measure,
        "seq": seq,
        "qty": qty,
      };
}

class FullNutrient {
  FullNutrient({
    this.id,
    this.foodId,
    this.attrId,
    this.value,
  });
  int? id;
  int? foodId;
  int? attrId;
  double? value;

  factory FullNutrient.fromJson(Map<String, dynamic> json) => FullNutrient(
        id: json['id'],
        foodId: json['foodId'],
        attrId: json["attr_id"],
        value: json["value"] == null ? null : json["value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'foodId': foodId,
        "attr_id": attrId,
        "value": value,
      };
}

class Photo {
  Photo({
    this.id,
    this.foodId,
    this.thumb,
    this.highres,
  });
  int? id;
  int? foodId;
  String? thumb;
  String? highres;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'],
        foodId: json['foodId'],
        thumb: json["thumb"],
        highres: json["highres"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'foodId': foodId,
        "thumb": thumb.toString(),
        "highres": highres.toString(),
      };
}