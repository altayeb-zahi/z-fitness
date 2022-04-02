// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RecipeSearchModel welcomeFromJson(String str) =>
    RecipeSearchModel.fromJson(json.decode(str));

String welcomeToJson(RecipeSearchModel data) => json.encode(data.toJson());

class RecipeSearchModel {
  RecipeSearchModel({
    this.offset,
    this.number,
    this.results,
    this.totalResults,
  });

  int? offset;
  int? number;
  List<RecipeResult>? results;
  int? totalResults;

  factory RecipeSearchModel.fromJson(Map<String, dynamic> json) =>
      RecipeSearchModel(
        offset: json["offset"],
        number: json["number"],
        results: List<RecipeResult>.from(
            json["results"].map((x) => RecipeResult.fromMap(x))),
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "number": number,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
        "totalResults": totalResults,
      };
}

class RecipeResult {
  RecipeResult({
    this.databaseId,
    this.recipeId,
    this.id,
    this.calories,
    this.carbs,
    this.fat,
    this.image,
    this.imageType,
    this.protein,
    this.title,
  });

  int? databaseId;
  int? recipeId; //for database foreinKey

  int? id;
  int? calories;
  String? carbs;
  String? fat;
  String? image;
  String? imageType;
  String? protein;
  String? title;

  factory RecipeResult.fromMap(Map<String, dynamic> json) => RecipeResult(
        databaseId: json['databaseId'],
        recipeId: json['recipeId'],
        id: json["id"],
        calories: json["calories"],
        carbs: json["carbs"],
        fat: json["fat"],
        image: json["image"],
        imageType: json["imageType"],
        protein: json["protein"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        'databaseId': databaseId,
        'recipeId': recipeId,
        "id": id,
        "calories": calories,
        "carbs": carbs,
        "fat": fat,
        "image": image,
        "imageType": imageType,
        "protein": protein,
        "title": title,
      };
}