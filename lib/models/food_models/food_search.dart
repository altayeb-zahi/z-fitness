// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SearchedFood welcomeFromJson(String str) =>
    SearchedFood.fromJson(json.decode(str));

String welcomeToJson(SearchedFood data) => json.encode(data.toJson());

class SearchedFood {
  SearchedFood({
    this.common,
    this.branded,
  });

  List<Common>? common;
  List<Branded>? branded;

  factory SearchedFood.fromJson(Map<String, dynamic> json) => SearchedFood(
        common:
            List<Common>.from(json["common"].map((x) => Common.fromJson(x))),
        branded:
            List<Branded>.from(json["branded"].map((x) => Branded.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "common": List<dynamic>.from(common!.map((x) => x.toJson())),
        "branded": List<dynamic>.from(branded!.map((x) => x.toJson())),
      };
}

class Branded {
  Branded({
    this.foodName,
    this.servingUnit,
    this.nixBrandId,
    this.brandNameItemName,
    this.servingQty,
    this.nfCalories,
    this.photo,
    this.brandName,
    this.region,
    this.brandType,
    this.nixItemId,
    this.locale,
  });

  String? foodName;
  String? servingUnit;
  String? nixBrandId;
  String? brandNameItemName;
  double? servingQty;
  double? nfCalories;
  BrandedPhoto? photo;
  String? brandName;
  int? region;
  int? brandType;
  String? nixItemId;
  Locale? locale;

  factory Branded.fromJson(Map<String, dynamic> json) => Branded(
        foodName: json["food_name"],
        servingUnit: json["serving_unit"],
        nixBrandId: json["nix_brand_id"],
        brandNameItemName: json["brand_name_item_name"],
        servingQty: json["serving_qty"].toDouble(),
        nfCalories: json["nf_calories"].toDouble(),
        photo: BrandedPhoto.fromJson(json["photo"]),
        brandName: json["brand_name"],
        region: json["region"],
        brandType: json["brand_type"],
        nixItemId: json["nix_item_id"],
        locale: localeValues.map[json["locale"]],
      );

  Map<String, dynamic> toJson() => {
        "food_name": foodName,
        "serving_unit": servingUnit,
        "nix_brand_id": nixBrandId,
        "brand_name_item_name": brandNameItemName,
        "serving_qty": servingQty,
        "nf_calories": nfCalories,
        "photo": photo!.toJson(),
        "brand_name": brandName,
        "region": region,
        "brand_type": brandType,
        "nix_item_id": nixItemId,
        "locale": localeValues.reverse![locale!],
      };
}

// ignore: constant_identifier_names
enum Locale { EN_US }

final localeValues = EnumValues({"en_US": Locale.EN_US});

class BrandedPhoto {
  BrandedPhoto({
    this.thumb,
  });

  String? thumb;

  factory BrandedPhoto.fromJson(Map<String, dynamic> json) => BrandedPhoto(
        thumb: json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
      };
}

class Common {
  Common({
    this.foodName,
    this.servingUnit,
    this.tagName,
    this.servingQty,
    this.commonType,
    this.tagId,
    this.photo,
    this.locale,
  });

  String? foodName;
  String? servingUnit;
  String? tagName;
  double? servingQty;
  int? commonType;
  String? tagId;
  CommonPhoto? photo;
  Locale? locale;

  factory Common.fromJson(Map<String, dynamic> json) => Common(
        foodName: json["food_name"],
        servingUnit: json["serving_unit"],
        tagName: json["tag_name"],
        servingQty: json["serving_qty"].toDouble(),
        commonType: json["common_type"],
        tagId: json["tag_id"],
        photo: CommonPhoto.fromJson(json["photo"]),
        locale: localeValues.map[json["locale"]],
      );

  Map<String, dynamic> toJson() => {
        "food_name": foodName,
        "serving_unit": servingUnit,
        "tag_name": tagName,
        "serving_qty": servingQty,
        "common_type": commonType,
        "tag_id": tagId,
        "photo": photo!.toJson(),
        "locale": localeValues.reverse![locale!],
      };
}

class CommonPhoto {
  CommonPhoto({
    this.thumb,
    this.highres,
    this.isUserUploaded,
  });

  String? thumb;
  dynamic highres;
  bool? isUserUploaded;

  factory CommonPhoto.fromJson(Map<String, dynamic> json) => CommonPhoto(
        thumb: json["thumb"],
        highres: json["highres"],
        isUserUploaded:
            json["is_user_uploaded"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "highres": highres,
        "is_user_uploaded": isUserUploaded,
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