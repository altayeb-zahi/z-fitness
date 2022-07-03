// To parse this JSON data, do
//
//     final recipeDetails = recipeDetailsFromMap(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class RecipeDetails {
  RecipeDetails({
    this.recipeToNutrients,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.lowFodmap,
    this.aggregateLikes,
    this.spoonacularScore,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.imageType,
    this.nutrition,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.winePairing,
    this.instructions,
    this.analyzedInstructions,
    this.originalId,
    this.spoonacularSourceUrl,
  });
  // to store value of calories, fat, protien and carbs
  final RecipeToNutrients? recipeToNutrients;
  //
  final bool? vegetarian;
  final bool? vegan;
  final bool? glutenFree;
  final bool? dairyFree;
  final bool? veryHealthy;
  final bool? cheap;
  final bool? veryPopular;
  final bool? sustainable;
  final int? weightWatcherSmartPoints;
  final String? gaps;
  final bool? lowFodmap;
  final int? aggregateLikes;
  final double? spoonacularScore;
  final double? healthScore;
  final String? creditsText;
  final String? license;
  final String? sourceName;
  final double? pricePerServing;
  final List<ExtendedIngredient>? extendedIngredients;
  final int? id;
  final String? title;
  final int? readyInMinutes;
  final int? servings;
  final String? sourceUrl;
  final String? image;
  final String? imageType;
  final Nutrition? nutrition;
  final String? summary;
  final List<dynamic>? cuisines;
  final List<String>? dishTypes;
  final List<dynamic>? diets;
  final List<dynamic>? occasions;
  final WinePairing? winePairing;
  final String? instructions;
  final List<dynamic>? analyzedInstructions;
  final dynamic originalId;
  final String? spoonacularSourceUrl;

  factory RecipeDetails.fromJson(String str) =>
      RecipeDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeDetails.fromMap(Map<String, dynamic> json) => RecipeDetails(
        recipeToNutrients:
            getRecipeTopNutrients(Nutrition.fromMap(json["nutrition"])),
        //
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        gaps: json["gaps"],
        lowFodmap: json["lowFodmap"],
        aggregateLikes: json["aggregateLikes"],
        spoonacularScore: json["spoonacularScore"],
        healthScore: json["healthScore"].toDouble(),
        creditsText: json["creditsText"],
        license: json["license"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"].toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(
            json["extendedIngredients"]
                .map((x) => ExtendedIngredient.fromMap(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        image: json["image"],
        imageType: json["imageType"],
        nutrition: Nutrition.fromMap(json["nutrition"]),
        summary: json["summary"],
        cuisines: List<dynamic>.from(json["cuisines"].map((x) => x)),
        dishTypes: List<String>.from(json["dishTypes"].map((x) => x)),
        diets: List<dynamic>.from(json["diets"].map((x) => x)),
        occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
        winePairing: WinePairing.fromMap(json["winePairing"]),
        instructions: json["instructions"],
        analyzedInstructions:
            List<dynamic>.from(json["analyzedInstructions"].map((x) => x)),
        originalId: json["originalId"],
        spoonacularSourceUrl: json["spoonacularSourceUrl"],
      );

  Map<String, dynamic> toMap() => {
        "vegetarian": vegetarian,
        "vegan": vegan,
        "glutenFree": glutenFree,
        "dairyFree": dairyFree,
        "veryHealthy": veryHealthy,
        "cheap": cheap,
        "veryPopular": veryPopular,
        "sustainable": sustainable,
        "weightWatcherSmartPoints": weightWatcherSmartPoints,
        "gaps": gaps,
        "lowFodmap": lowFodmap,
        "aggregateLikes": aggregateLikes,
        "spoonacularScore": spoonacularScore,
        "healthScore": healthScore,
        "creditsText": creditsText,
        "license": license,
        "sourceName": sourceName,
        "pricePerServing": pricePerServing,
        "extendedIngredients": extendedIngredients != null
            ? List<dynamic>.from(extendedIngredients!.map((x) => x.toMap()))
            : null,
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "image": image,
        "imageType": imageType,
        "nutrition": nutrition != null ? nutrition!.toMap() : null,
        "summary": summary,
        "cuisines": cuisines != null
            ? List<dynamic>.from(cuisines!.map((x) => x))
            : null,
        "dishTypes": dishTypes != null
            ? List<dynamic>.from(dishTypes!.map((x) => x))
            : null,
        "diets":
            diets != null ? List<dynamic>.from(diets!.map((x) => x)) : null,
        "occasions": occasions != null
            ? List<dynamic>.from(occasions!.map((x) => x))
            : null,
        "winePairing": winePairing != null ? winePairing!.toMap() : null,
        "instructions": instructions,
        "analyzedInstructions": analyzedInstructions != null
            ? List<dynamic>.from(analyzedInstructions!.map((x) => x))
            : null,
        "originalId": originalId,
        "spoonacularSourceUrl": spoonacularSourceUrl,
      };
}

RecipeToNutrients getRecipeTopNutrients(Nutrition nutrition) {
  late int _calories;
  late int _protein;
  late int _carb;
  late int _fat;

  for (var element in nutrition.nutrients!) {
    if (element.name == 'Calories') _calories = element.amount!.round();
    if (element.name == 'Protein') _protein = element.amount!.round();
    if (element.name == 'Carbohydrates') _carb = element.amount!.round();
    if (element.name == 'Fat') _fat = element.amount!.round();
  }

  return RecipeToNutrients(
      calories: _calories, protein: _protein, carb: _carb, fat: _fat);
}

class RecipeToNutrients {
  int calories;
  int protein;
  int carb;
  int fat;
  RecipeToNutrients({
    required this.calories,
    required this.protein,
    required this.carb,
    required this.fat,
  });
}

class ExtendedIngredient {
  ExtendedIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  final int? id;
  final String? aisle;
  final String? image;
  final Consistency? consistency;
  final String? name;
  final String? nameClean;
  final String? original;
  final String? originalName;
  final double? amount;
  final String? unit;
  final List<String>? meta;
  final Measures? measures;

  factory ExtendedIngredient.fromJson(String str) =>
      ExtendedIngredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExtendedIngredient.fromMap(Map<String, dynamic> json) =>
      ExtendedIngredient(
        id: json["id"],
        aisle: json["aisle"],
        image: json["image"],
        consistency: consistencyValues.map[json["consistency"]],
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalName: json["originalName"],
        amount: json["amount"].toDouble(),
        unit: json["unit"],
        meta: List<String>.from(json["meta"].map((x) => x)),
        measures: Measures.fromMap(json["measures"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "aisle": aisle,
        "image": image,
        "consistency": consistencyValues.reverse != null
            ? consistencyValues.reverse![consistency]
            : null,
        "name": name,
        "nameClean": nameClean,
        "original": original,
        "originalName": originalName,
        "amount": amount,
        "unit": unit,
        "meta": meta != null ? List<dynamic>.from(meta!.map((x) => x)) : null,
        "measures": measures != null ? measures!.toMap() : null,
      };
}

enum Consistency { solid, liquid }

final consistencyValues =
    EnumValues({"liquid": Consistency.liquid, "solid": Consistency.solid});

class Measures {
  Measures({
    this.us,
    this.metric,
  });

  final Metric? us;
  final Metric? metric;

  factory Measures.fromJson(String str) => Measures.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Measures.fromMap(Map<String, dynamic> json) => Measures(
        us: Metric.fromMap(json["us"]),
        metric: Metric.fromMap(json["metric"]),
      );

  Map<String, dynamic> toMap() => {
        "us": us != null ? us!.toMap() : null,
        "metric": metric != null ? metric!.toMap() : null,
      };
}

class Metric {
  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  final double? amount;
  final String? unitShort;
  final String? unitLong;

  factory Metric.fromJson(String str) => Metric.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Metric.fromMap(Map<String, dynamic> json) => Metric(
        amount: json["amount"].toDouble(),
        unitShort: json["unitShort"],
        unitLong: json["unitLong"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "unitShort": unitShort,
        "unitLong": unitLong,
      };
}

class Nutrition {
  Nutrition({
    this.nutrients,
    this.properties,
    this.flavonoids,
    this.ingredients,
    this.caloricBreakdown,
    this.weightPerServing,
  });

  final List<Flavonoid>? nutrients;
  final List<Flavonoid>? properties;
  final List<Flavonoid>? flavonoids;
  final List<Ingredient>? ingredients;
  final CaloricBreakdown? caloricBreakdown;
  final WeightPerServing? weightPerServing;

  factory Nutrition.fromJson(String str) => Nutrition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nutrition.fromMap(Map<String, dynamic> json) => Nutrition(
        nutrients: List<Flavonoid>.from(
            json["nutrients"].map((x) => Flavonoid.fromMap(x))),
        properties: List<Flavonoid>.from(
            json["properties"].map((x) => Flavonoid.fromMap(x))),
        flavonoids: List<Flavonoid>.from(
            json["flavonoids"].map((x) => Flavonoid.fromMap(x))),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromMap(x))),
        caloricBreakdown: CaloricBreakdown.fromMap(json["caloricBreakdown"]),
        weightPerServing: WeightPerServing.fromMap(json["weightPerServing"]),
      );

  Map<String, dynamic> toMap() => {
        "nutrients": nutrients != null
            ? List<dynamic>.from(nutrients!.map((x) => x.toMap()))
            : null,
        "properties": properties != null
            ? List<dynamic>.from(properties!.map((x) => x.toMap()))
            : null,
        "flavonoids": flavonoids != null
            ? List<dynamic>.from(flavonoids!.map((x) => x.toMap()))
            : null,
        "ingredients": ingredients != null
            ? List<dynamic>.from(ingredients!.map((x) => x.toMap()))
            : null,
        "caloricBreakdown":
            caloricBreakdown != null ? caloricBreakdown!.toMap() : null,
        "weightPerServing":
            weightPerServing != null ? weightPerServing!.toMap() : null,
      };
}

class CaloricBreakdown {
  CaloricBreakdown({
    this.percentProtein,
    this.percentFat,
    this.percentCarbs,
  });

  final double? percentProtein;
  final double? percentFat;
  final double? percentCarbs;

  factory CaloricBreakdown.fromJson(String str) =>
      CaloricBreakdown.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CaloricBreakdown.fromMap(Map<String, dynamic> json) =>
      CaloricBreakdown(
        percentProtein: json["percentProtein"].toDouble(),
        percentFat: json["percentFat"].toDouble(),
        percentCarbs: json["percentCarbs"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "percentProtein": percentProtein,
        "percentFat": percentFat,
        "percentCarbs": percentCarbs,
      };
}

class Flavonoid {
  Flavonoid({
    this.name,
    this.amount,
    this.unit,
    this.percentOfDailyNeeds,
  });

  final String? name;
  final double? amount;
  final Unit? unit;
  final double? percentOfDailyNeeds;

  factory Flavonoid.fromJson(String str) => Flavonoid.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Flavonoid.fromMap(Map<String, dynamic> json) => Flavonoid(
        name: json["name"],
        amount: json["amount"].toDouble(),
        unit: unitValues.map[json["unit"]],
        percentOfDailyNeeds: json["percentOfDailyNeeds"] == null
            ? null
            : json["percentOfDailyNeeds"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "amount": amount,
        "unit": unitValues.reverse != null ? unitValues.reverse![unit] : null,
        "percentOfDailyNeeds": percentOfDailyNeeds,
      };
}

// ignore: constant_identifier_names
enum Unit { MG, EMPTY, G, UNIT_G, KCAL, IU }

final unitValues = EnumValues({
  "": Unit.EMPTY,
  "g": Unit.G,
  "IU": Unit.IU,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class Ingredient {
  Ingredient({
    this.id,
    this.name,
    this.amount,
    this.unit,
    this.nutrients,
  });

  final int? id;
  final String? name;
  final double? amount;
  final String? unit;
  final List<Flavonoid>? nutrients;

  factory Ingredient.fromJson(String str) =>
      Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        amount: json["amount"].toDouble(),
        unit: json["unit"],
        nutrients: List<Flavonoid>.from(
            json["nutrients"].map((x) => Flavonoid.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "amount": amount,
        "unit": unit,
        "nutrients": nutrients != null
            ? List<dynamic>.from(nutrients!.map((x) => x.toMap()))
            : null,
      };
}

class WeightPerServing {
  WeightPerServing({
    this.amount,
    this.unit,
  });

  final int? amount;
  final Unit? unit;

  factory WeightPerServing.fromJson(String str) =>
      WeightPerServing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeightPerServing.fromMap(Map<String, dynamic> json) =>
      WeightPerServing(
        amount: json["amount"],
        unit: unitValues.map[json["unit"]],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "unit": unitValues.reverse != null ? unitValues.reverse![unit] : null,
      };
}

class WinePairing {
  WinePairing({
    this.pairedWines,
    this.pairingText,
    this.productMatches,
  });

  final List<dynamic>? pairedWines;
  final String? pairingText;
  final List<dynamic>? productMatches;

  factory WinePairing.fromJson(String str) =>
      WinePairing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WinePairing.fromMap(Map<String, dynamic> json) => WinePairing(
        pairedWines: json["pairedWines"] != null
            ? List<dynamic>.from(json["pairedWines"].map((x) => x))
            : null,
        pairingText: json["pairingText"],
        productMatches: json["productMatches"] != null
            ? List<dynamic>.from(json["productMatches"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toMap() => {
        "pairedWines": pairedWines != null
            ? List<dynamic>.from(pairedWines!.map((x) => x))
            : null,
        "pairingText": pairingText,
        "productMatches": productMatches != null
            ? List<dynamic>.from(productMatches!.map((x) => x))
            : null,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
