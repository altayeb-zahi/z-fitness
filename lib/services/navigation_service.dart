// import 'package:flutter/material.dart';

// class NavigationService {
//   final GlobalKey<NavigatorState> navigatorKey =
//        GlobalKey<NavigatorState>();

//   Future<dynamic> navigateTo(String routeName,{dynamic arguments}) {
//     return navigatorKey.currentState!.pushNamed(routeName,arguments: arguments);
//   }

//    Future<dynamic> replaceWith(String routeName,{dynamic arguments}) {
//     return navigatorKey.currentState!.pushReplacementNamed(routeName);
//   }

//   Future<dynamic> clearStackAndShow(String routeName,{dynamic arguments}) {
//     return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
//   }

//   void goBack() {
//     return navigatorKey.currentState!.pop();
//   }
// }