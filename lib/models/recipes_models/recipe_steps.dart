// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<RecipeStepsModel> welcomeFromJson(String str) =>
    List<RecipeStepsModel>.from(
        json.decode(str).map((x) => RecipeStepsModel.fromJson(x)));

String welcomeToJson(List<RecipeStepsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeStepsModel {
  RecipeStepsModel({
    this.name,
    this.steps,
  });

  String? name;
  List<Step>? steps;

  factory RecipeStepsModel.fromJson(Map<String, dynamic> json) =>
      RecipeStepsModel(
        name: json["name"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "steps": List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}

class Step {
  Step({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
  });

  int? number;
  String? step;
  List<Ent>? ingredients;
  List<Ent>? equipment;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        number: json["number"],
        step: json["step"],
        ingredients:
            List<Ent>.from(json["ingredients"].map((x) => Ent.fromJson(x))),
        equipment:
            List<Ent>.from(json["equipment"].map((x) => Ent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "step": step,
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "equipment": List<dynamic>.from(equipment!.map((x) => x.toJson())),
      };
}

class Ent {
  Ent({
    this.id,
    this.name,
    this.localizedName,
    this.image,
  });

  int? id;
  String? name;
  String? localizedName;
  String? image;

  factory Ent.fromJson(Map<String, dynamic> json) => Ent(
        id: json["id"],
        name: json["name"],
        localizedName: json["localizedName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "localizedName": localizedName,
        "image": image,
      };
}