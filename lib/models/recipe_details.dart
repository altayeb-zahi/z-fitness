// To parse this JSON data, do
//
//     final recipeDetails = recipeDetailsFromMap(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class RecipeDetails {
    RecipeDetails({
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
    final int? spoonacularScore;
    final int? healthScore;
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

    factory RecipeDetails.fromJson(String str) => RecipeDetails.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RecipeDetails.fromMap(Map<String, dynamic> json) => RecipeDetails(
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
        healthScore: json["healthScore"],
        creditsText: json["creditsText"],
        license: json["license"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"].toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(json["extendedIngredients"].map((x) => ExtendedIngredient.fromMap(x))),
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
        analyzedInstructions: List<dynamic>.from(json["analyzedInstructions"].map((x) => x)),
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
        "extendedIngredients": extendedIngredients!=null? List<dynamic>.from(extendedIngredients!.map((x) => x.toMap())):null,
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "image": image,
        "imageType": imageType,
        "nutrition": nutrition!=null? nutrition!.toMap():null,
        "summary": summary,
        "cuisines":cuisines !=null? List<dynamic>.from(cuisines!.map((x) => x)):null,
        "dishTypes": dishTypes!=null? List<dynamic>.from(dishTypes!.map((x) => x)):null,
        "diets": diets!=null? List<dynamic>.from(diets!.map((x) => x)):null,
        "occasions": occasions!=null?List<dynamic>.from(occasions!.map((x) => x)):null,
        "winePairing": winePairing != null? winePairing!.toMap():null,
        "instructions": instructions,
        "analyzedInstructions": analyzedInstructions != null? List<dynamic>.from(analyzedInstructions!.map((x) => x)):null,
        "originalId": originalId,
        "spoonacularSourceUrl": spoonacularSourceUrl,
    };
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

    factory ExtendedIngredient.fromJson(String str) => ExtendedIngredient.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ExtendedIngredient.fromMap(Map<String, dynamic> json) => ExtendedIngredient(
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
        "consistency":consistencyValues.reverse != null? consistencyValues.reverse![consistency]:null,
        "name": name,
        "nameClean": nameClean,
        "original": original,
        "originalName": originalName,
        "amount": amount,
        "unit": unit,
        "meta": meta != null? List<dynamic>.from(meta!.map((x) => x)):null,
        "measures": measures!= null? measures!.toMap():null,
    };
}

enum Consistency { solid, liquid }

final consistencyValues = EnumValues({
    "liquid": Consistency.liquid,
    "solid": Consistency.solid
});

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
        "us": us != null? us!.toMap():null,
        "metric": metric != null?  metric!.toMap():null,
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
        nutrients: List<Flavonoid>.from(json["nutrients"].map((x) => Flavonoid.fromMap(x))),
        properties: List<Flavonoid>.from(json["properties"].map((x) => Flavonoid.fromMap(x))),
        flavonoids: List<Flavonoid>.from(json["flavonoids"].map((x) => Flavonoid.fromMap(x))),
        ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromMap(x))),
        caloricBreakdown: CaloricBreakdown.fromMap(json["caloricBreakdown"]),
        weightPerServing: WeightPerServing.fromMap(json["weightPerServing"]),
    );

    Map<String, dynamic> toMap() => {
        "nutrients": nutrients != null? List<dynamic>.from(nutrients!.map((x) => x.toMap())):null,
        "properties": properties!= null? List<dynamic>.from(properties!.map((x) => x.toMap())):null,
        "flavonoids": flavonoids!=null? List<dynamic>.from(flavonoids!.map((x) => x.toMap())):null,
        "ingredients": ingredients!=null? List<dynamic>.from(ingredients!.map((x) => x.toMap())):null,
        "caloricBreakdown":caloricBreakdown!=null? caloricBreakdown!.toMap():null,
        "weightPerServing":weightPerServing!=null? weightPerServing!.toMap():null,
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

    factory CaloricBreakdown.fromJson(String str) => CaloricBreakdown.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CaloricBreakdown.fromMap(Map<String, dynamic> json) => CaloricBreakdown(
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
        percentOfDailyNeeds: json["percentOfDailyNeeds"] == null ? null : json["percentOfDailyNeeds"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "amount": amount,
        "unit":unitValues.reverse != null? unitValues.reverse![unit]:null,
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

    factory Ingredient.fromJson(String str) => Ingredient.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        amount: json["amount"].toDouble(),
        unit: json["unit"],
        nutrients: List<Flavonoid>.from(json["nutrients"].map((x) => Flavonoid.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "amount": amount,
        "unit": unit,
        "nutrients":nutrients!=null? List<dynamic>.from(nutrients!.map((x) => x.toMap())):null,
    };
}

class WeightPerServing {
    WeightPerServing({
        this.amount,
        this.unit,
    });

    final int? amount;
    final Unit? unit;

    factory WeightPerServing.fromJson(String str) => WeightPerServing.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WeightPerServing.fromMap(Map<String, dynamic> json) => WeightPerServing(
        amount: json["amount"],
        unit: unitValues.map[json["unit"]],
    );

    Map<String, dynamic> toMap() => {
        "amount": amount,
        "unit": unitValues.reverse!=null? unitValues.reverse![unit]:null,
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

    factory WinePairing.fromJson(String str) => WinePairing.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WinePairing.fromMap(Map<String, dynamic> json) => WinePairing(
        pairedWines: List<dynamic>.from(json["pairedWines"].map((x) => x)),
        pairingText: json["pairingText"],
        productMatches: List<dynamic>.from(json["productMatches"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "pairedWines": pairedWines!=null? List<dynamic>.from(pairedWines!.map((x) => x)):null,
        "pairingText": pairingText,
        "productMatches": productMatches!=null? List<dynamic>.from(productMatches!.map((x) => x)):null,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

     Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) =>  MapEntry(v, k));
        return reverseMap;
    }
}



















// // To parse this JSON data, do
// //
// //     final recipeDetails = recipeDetailsFromMap(jsonString);

// import 'dart:convert';

// class RecipeDetails {
//     RecipeDetails({
//         this.id,
//         this.title,
//         this.image,
//         this.imageType,
//         this.servings,
//         this.readyInMinutes,
//         this.license,
//         this.sourceName,
//         this.sourceUrl,
//         this.spoonacularSourceUrl,
//         this.aggregateLikes,
//         this.healthScore,
//         this.spoonacularScore,
//         this.pricePerServing,
//         this.analyzedInstructions,
//         this.cheap,
//         this.creditsText,
//         this.cuisines,
//         this.dairyFree,
//         this.diets,
//         this.gaps,
//         this.glutenFree,
//         this.instructions,
//         this.ketogenic,
//         this.lowFodmap,
//         this.occasions,
//         this.sustainable,
//         this.vegan,
//         this.vegetarian,
//         this.veryHealthy,
//         this.veryPopular,
//         this.whole30,
//         this.weightWatcherSmartPoints,
//         this.dishTypes,
//         this.extendedIngredients,
//         this.summary,
//         this.winePairing,
//     });

//     final int? id;
//     final String? title;
//     final String? image;
//     final String? imageType;
//     final int? servings;
//     final int? readyInMinutes;
//     final String? license;
//     final String? sourceName;
//     final String? sourceUrl;
//     final String? spoonacularSourceUrl;
//     final int? aggregateLikes;
//     final int? healthScore;
//     final int? spoonacularScore;
//     final double? pricePerServing;
//     final List<dynamic>? analyzedInstructions;
//     final bool? cheap;
//     final String? creditsText;
//     final List<dynamic>? cuisines;
//     final bool? dairyFree;
//     final List<dynamic>? diets;
//     final String? gaps;
//     final bool? glutenFree;
//     final String? instructions;
//     final bool? ketogenic;
//     final bool? lowFodmap;
//     final List<dynamic>? occasions;
//     final bool? sustainable;
//     final bool? vegan;
//     final bool? vegetarian;
//     final bool? veryHealthy;
//     final bool? veryPopular;
//     final bool? whole30;
//     final int? weightWatcherSmartPoints;
//     final List<String>? dishTypes;
//     final List<ExtendedIngredient>? extendedIngredients;
//     final String? summary;
//     final WinePairing? winePairing;

//     factory RecipeDetails.fromJson(String str) => RecipeDetails.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory RecipeDetails.fromMap(Map<String, dynamic> json) => RecipeDetails(
//         id: json["id"],
//         title: json["title"],
//         image: json["image"],
//         imageType: json["imageType"],
//         servings: json["servings"],
//         readyInMinutes: json["readyInMinutes"],
//         license: json["license"],
//         sourceName: json["sourceName"],
//         sourceUrl: json["sourceUrl"],
//         spoonacularSourceUrl: json["spoonacularSourceUrl"],
//         aggregateLikes: json["aggregateLikes"],
//         healthScore: json["healthScore"],
//         spoonacularScore: json["spoonacularScore"],
//         pricePerServing: json["pricePerServing"].toDouble(),
//         analyzedInstructions: List<dynamic>.from(json["analyzedInstructions"].map((x) => x)),
//         cheap: json["cheap"],
//         creditsText: json["creditsText"],
//         cuisines: List<dynamic>.from(json["cuisines"].map((x) => x)),
//         dairyFree: json["dairyFree"],
//         diets: List<dynamic>.from(json["diets"].map((x) => x)),
//         gaps: json["gaps"],
//         glutenFree: json["glutenFree"],
//         instructions: json["instructions"],
//         ketogenic: json["ketogenic"],
//         lowFodmap: json["lowFodmap"],
//         occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
//         sustainable: json["sustainable"],
//         vegan: json["vegan"],
//         vegetarian: json["vegetarian"],
//         veryHealthy: json["veryHealthy"],
//         veryPopular: json["veryPopular"],
//         whole30: json["whole30"],
//         weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
//         dishTypes: List<String>.from(json["dishTypes"].map((x) => x)),
//         extendedIngredients: List<ExtendedIngredient>.from(json["extendedIngredients"].map((x) => ExtendedIngredient.fromMap(x))),
//         summary: json["summary"],
//         winePairing: WinePairing.fromMap(json["winePairing"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "image": image,
//         "imageType": imageType,
//         "servings": servings,
//         "readyInMinutes": readyInMinutes,
//         "license": license,
//         "sourceName": sourceName,
//         "sourceUrl": sourceUrl,
//         "spoonacularSourceUrl": spoonacularSourceUrl,
//         "aggregateLikes": aggregateLikes,
//         "healthScore": healthScore,
//         "spoonacularScore": spoonacularScore,
//         "pricePerServing": pricePerServing,
//         "analyzedInstructions":analyzedInstructions != null? List<dynamic>.from(analyzedInstructions!.map((x) => x)):null,
//         "cheap": cheap,
//         "creditsText": creditsText,
//         "cuisines": cuisines != null? List<dynamic>.from(cuisines!.map((x) => x)):null,
//         "dairyFree": dairyFree,
//         "diets": diets != null? List<dynamic>.from(diets!.map((x) => x)):null,
//         "gaps": gaps,
//         "glutenFree": glutenFree,
//         "instructions": instructions,
//         "ketogenic": ketogenic,
//         "lowFodmap": lowFodmap,
//         "occasions": occasions != null? List<dynamic>.from(occasions!.map((x) => x)):null,
//         "sustainable": sustainable,
//         "vegan": vegan,
//         "vegetarian": vegetarian,
//         "veryHealthy": veryHealthy,
//         "veryPopular": veryPopular,
//         "whole30": whole30,
//         "weightWatcherSmartPoints": weightWatcherSmartPoints,
//         "dishTypes": dishTypes != null? List<dynamic>.from(dishTypes!.map((x) => x)):null,
//         "extendedIngredients": extendedIngredients != null? List<dynamic>.from(extendedIngredients!.map((x) => x.toMap())):null,
//         "summary": summary,
//         "winePairing": winePairing != null? winePairing!.toMap(): null,
//     };
// }

// class ExtendedIngredient {
//     ExtendedIngredient({
//         this.aisle,
//         this.amount,
//         this.consitency,
//         this.id,
//         this.image,
//         this.measures,
//         this.meta,
//         this.name,
//         this.original,
//         this.originalName,
//         this.unit,
//     });

//     final String? aisle;
//     final double? amount;
//     final Consitency? consitency;
//     final int? id;
//     final String? image;
//     final Measures? measures;
//     final List<String>? meta;
//     final String? name;
//     final String? original;
//     final String? originalName;
//     final String? unit;

//     factory ExtendedIngredient.fromJson(String str) => ExtendedIngredient.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory ExtendedIngredient.fromMap(Map<String, dynamic> json) => ExtendedIngredient(
//         aisle: json["aisle"],
//         amount: json["amount"].toDouble(),
//         consitency: consitencyValues.map[json["consitency"]],
//         id: json["id"],
//         image: json["image"],
//         measures: Measures.fromMap(json["measures"]),
//         meta: List<String>.from(json["meta"].map((x) => x)),
//         name: json["name"],
//         original: json["original"],
//         originalName: json["originalName"],
//         unit: json["unit"],
//     );

//     Map<String, dynamic> toMap() => {
//         "aisle": aisle,
//         "amount": amount,
//         "consitency":consitencyValues.reverse != null? consitencyValues.reverse![consitency]:null,
//         "id": id,
//         "image": image,
//         "measures":measures != null? measures!.toMap():null,
//         "meta": meta != null? List<dynamic>.from(meta!.map((x) => x)):null,
//         "name": name,
//         "original": original,
//         "originalName": originalName,
//         "unit": unit,
//     };
// }

// enum Consitency { solid, liquid }

// final consitencyValues = EnumValues({
//     "liquid": Consitency.liquid,
//     "solid": Consitency.solid
// });

// class Measures {
//     Measures({
//         this.metric,
//         this.us,
//     });

//     final Metric? metric;
//     final Metric? us;

//     factory Measures.fromJson(String str) => Measures.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Measures.fromMap(Map<String, dynamic> json) => Measures(
//         metric: Metric.fromMap(json["metric"]),
//         us: Metric.fromMap(json["us"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "metric":metric!=null? metric!.toMap():null,
//         "us": us!=null? us!.toMap():null,
//     };
// }

// class Metric {
//     Metric({
//         this.amount,
//         this.unitLong,
//         this.unitShort,
//     });

//     final double? amount;
//     final String? unitLong;
//     final String? unitShort;

//     factory Metric.fromJson(String str) => Metric.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Metric.fromMap(Map<String, dynamic> json) => Metric(
//         amount: json["amount"].toDouble(),
//         unitLong: json["unitLong"],
//         unitShort: json["unitShort"],
//     );

//     Map<String, dynamic> toMap() => {
//         "amount": amount,
//         "unitLong": unitLong,
//         "unitShort": unitShort,
//     };
// }

// class WinePairing {
//     WinePairing({
//         this.pairedWines,
//         this.pairingText,
//         this.productMatches,
//     });

//     final List<String>? pairedWines;
//     final String? pairingText;
//     final List<ProductMatch>? productMatches;

//     factory WinePairing.fromJson(String str) => WinePairing.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory WinePairing.fromMap(Map<String, dynamic> json) => WinePairing(
//         pairedWines: List<String>.from(json["pairedWines"].map((x) => x)),
//         pairingText: json["pairingText"],
//         productMatches: List<ProductMatch>.from(json["productMatches"].map((x) => ProductMatch.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "pairedWines":pairedWines != null? List<dynamic>.from(pairedWines!.map((x) => x)):null,
//         "pairingText": pairingText,
//         "productMatches":productMatches != null? List<dynamic>.from(productMatches!.map((x) => x.toMap())):null,
//     };
// }

// class ProductMatch {
//     ProductMatch({
//         this.id,
//         this.title,
//         this.description,
//         this.price,
//         this.imageUrl,
//         this.averageRating,
//         this.ratingCount,
//         this.score,
//         this.link,
//     });

//     final int? id;
//     final String? title;
//     final String? description;
//     final String? price;
//     final String? imageUrl;
//     final double? averageRating;
//     final int? ratingCount;
//     final double? score;
//     final String? link;

//     factory ProductMatch.fromJson(String str) => ProductMatch.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory ProductMatch.fromMap(Map<String, dynamic> json) => ProductMatch(
//         id: json["id"],
//         title: json["title"],
//         description: json["description"],
//         price: json["price"],
//         imageUrl: json["imageUrl"],
//         averageRating: json["averageRating"].toDouble(),
//         ratingCount: json["ratingCount"],
//         score: json["score"].toDouble(),
//         link: json["link"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "price": price,
//         "imageUrl": imageUrl,
//         "averageRating": averageRating,
//         "ratingCount": ratingCount,
//         "score": score,
//         "link": link,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String>? reverseMap;

//   EnumValues(
//     this.map,
//   );

//     Map<T, String>? get reverse {
//         reverseMap ??= map.map((k, v) =>  MapEntry(v, k));
//         return reverseMap;
//     }
// }
