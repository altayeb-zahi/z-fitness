import 'package:flutter/material.dart';
import 'package:z_fitness/models/arguments_models.dart';
import 'package:z_fitness/ui/views/add_food/add_food_view.dart';
import 'package:z_fitness/ui/views/food_details/food_details_view.dart';
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
  static const String foodDetailsView = 'foodDetails';

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
      final addFoodArgument = settings.arguments as AddFoodArgument;
      return MaterialPageRoute(builder: (context) =>  AddFoodView(addFoodArgument: addFoodArgument,));

 case Routes.foodDetailsView:
      final foodDetailsArgument = settings.arguments as FoodDetailsArgument;
      return MaterialPageRoute(builder: (context) =>  FoodDetailsView(foodDetailsArgument: foodDetailsArgument,));

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
