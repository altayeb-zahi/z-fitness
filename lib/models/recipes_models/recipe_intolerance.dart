import 'dart:convert';

class IntoleranceModel {
  final String? intoleranceType;
  bool? isSelected = false;

  IntoleranceModel(this.intoleranceType, this.isSelected);

  Map<String, dynamic> toMap() {
    return {
      'intoleranceType': intoleranceType,
      'isSelected': isSelected,
    };
  }

  factory IntoleranceModel.fromMap(Map<String, dynamic> map) {
    return IntoleranceModel(
      map['intoleranceType'],
      map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IntoleranceModel.fromJson(String source) =>
      IntoleranceModel.fromMap(json.decode(source));
}