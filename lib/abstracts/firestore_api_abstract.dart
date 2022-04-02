import 'package:z_fitness/models/food_models/food_consumed.dart';

import '../models/user.dart';

abstract class FirestoreApiAbstract {
  Future<User?> getUser({required String userId});

  Future<void> createUser({required User user});

  Future<void> updateUser({required User user});

  Future addFoodConsumed( {
    required String userId,
    required FoodConsumed foodConsumed,
          required String date,
          required String meal});

}
