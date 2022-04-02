// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';


import '../../enums/recipes_related_enums.dart';

RecipeDietModel welcomeFromJson(String str) =>
    RecipeDietModel.fromJson(json.decode(str));

String welcomeToJson(RecipeDietModel data) => json.encode(data.toJson());

class RecipeDietModel {
  RecipeDietModel(
      {this.results,
      this.offset,
      this.number,
      this.totalResults,
      this.dietType});

  List<Result>? results;
  int? offset;
  int? number;
  int? totalResults;
  DietType? dietType;

  factory RecipeDietModel.fromJson(Map<String, dynamic> json) =>
      RecipeDietModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
      };
}

class Result {
  Result({
    this.id,
    this.title,
    this.image,
    this.imageType,
  });

  int? id;
  String? title;
  String? image;
  String? imageType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: json["imageType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageType,
      };
}