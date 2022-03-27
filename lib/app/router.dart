import 'package:flutter/material.dart';
import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/ui/views/add_food/add_food_view.dart';
import 'package:z_fitness/ui/views/user_info/user_info_view.dart';

import '../ui/views/create_account/create_account_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String homeView = 'Home';
  static const String createAccountView = 'CreateAccount';
  static const String loginView = 'Login';
  static const String startupView = 'Startup';
  static const String activitiesView = 'Activities';
  static const String userInfoView = 'UserInfo';
  static const String addFoodView = 'AddFood';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homeView:
      return MaterialPageRoute(builder: (context) => const HomeView());

    case Routes.createAccountView:
      return MaterialPageRoute(builder: (context) => const CreateAccountView());

    case Routes.loginView:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case Routes.startupView:
      return MaterialPageRoute(builder: (context) => const StartupView());

    case Routes.userInfoView:
      return MaterialPageRoute(builder: (context) => const UserInfoView());

    case Routes.addFoodView:
      final mealType = settings.arguments as MealType;
      return MaterialPageRoute(builder: (context) =>  AddFoodView(mealType: mealType,));

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
