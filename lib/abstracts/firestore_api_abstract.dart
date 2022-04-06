import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';

import '../models/user.dart';

abstract class FirestoreApiAbstract {
  Future<User?> getUser({required String userId});

  Future<void> createUser({required User user});

  Future<void> updateUser({required User user});

  Future addFoodConsumed(
      {required String userId,
      required FoodConsumed foodConsumed,
      required String date,
      required String mealType});

  Stream<QuerySnapshot<Map<String, dynamic>>> getFood(
      {required String userId, required String date, required String mealType});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream({
    required String userId,
  });

  Future deleteFood(
      {required String userId, required String foodId, required String date,required String mealType});
}
