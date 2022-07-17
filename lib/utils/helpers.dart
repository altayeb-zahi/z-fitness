import 'package:html/parser.dart';

import '../app/logger.dart';

T convertStringToEnum<T>(List<T> values, String value) {
  log.i(value);
  log.i(values);
  log.i(values.firstWhere((e) => e.toString().split(".").last == value));
  return values.firstWhere((e) => e.toString().split(".").last == value);
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}
