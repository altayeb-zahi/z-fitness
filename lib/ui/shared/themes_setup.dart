import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey.shade200,
  primaryColor: const Color(0xFF512D6D),
  iconTheme: const IconThemeData(color: Color(0xff00C1D4)),
  textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
      headline2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color(0xffF8485E)),
      bodyText1: TextStyle(fontSize: 14.0),
      bodyText2: TextStyle(fontSize: 12.0, color: Colors.grey)),
);

var darkTheme = ThemeData(
  backgroundColor: const Color(0xFF334756),
  scaffoldBackgroundColor: const Color(0xff2C394B),
  primaryColor: const Color(0xFF222831),
  iconTheme: const IconThemeData(color: Color(0xffFF4C29)),
  textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
      headline2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color(0xffF8485E)),
      bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
      bodyText2: TextStyle(fontSize: 12.0, color: Colors.grey)),
);