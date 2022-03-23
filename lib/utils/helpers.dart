T convertToEnum<T>(List<T> values, String value) {
  return values.firstWhere((e) => e.toString() == value);
}