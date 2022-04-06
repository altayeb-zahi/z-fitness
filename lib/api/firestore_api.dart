import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:z_fitness/models/food_models/food_consumed.dart';

import '../abstracts/firestore_api_abstract.dart';
import '../exceptions/firestore_api_exceptions.dart';
import '../models/user.dart';

class FirestoreApi implements FirestoreApiAbstract {
  final log = Logger();

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> createUser({required User user}) async {
    try {
      final userDocument = _usersCollection.doc(user.id);
      await userDocument.set(user.toMap());
      log.v('UserCreated at ${userDocument.path}');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
  }

  @override
  Future<User?> getUser({required String userId}) async {
    if (userId.isNotEmpty) {
      final userDoc = await _usersCollection.doc(userId).get();
      if (!userDoc.exists) {
        log.v('We have no user with id $userId in our database');
        return null;
      }

      final userData = userDoc.data();
      log.v('User found. Data: $userData');

      return User.fromMap(userData! as Map<String, dynamic>);
    } else {
      throw FirestoreApiException(
          message:
              'Your userId passed in is empty. Please pass in a valid user if from your Firebase user.');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getFood(
          {required String userId,
          required String date,
          required String mealType}) =>
      _usersCollection
          .doc(userId)
          .collection('foods')
          .doc(date)
          .collection(mealType)
          .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      getCaloriesDetailsForSpecificDay({
    required String userId,
    required String date,
  }) =>
          _usersCollection
              .doc(userId)
              .collection('foods')
              .doc(date)
              .snapshots();

  @override
  Future<void> updateUser({required User user}) async {
    log.i('user:$user');

    try {
      final userDocument = _usersCollection.doc(user.id);
      await userDocument.update(user.toMap());
      log.v('UserUpdated');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to update  user',
        devDetails: '$error',
      );
    }
  }

  @override
  Future addFoodConsumed(
      {required String userId,
      required FoodConsumed foodConsumed,
      required String date,
      required String mealType}) async {
    log.i('FirestoreApi - UserUpdated');

    try {
      await _usersCollection
          .doc(userId)
          .collection('foods')
          .doc(date)
          .collection(mealType)
          .add(foodConsumed.toMap());
    } catch (e) {
      log.e(e);
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
          {required String userId}) =>
      _usersCollection.doc(userId).snapshots()
          as Stream<DocumentSnapshot<Map<String, dynamic>>>;

  @override
  Future deleteFood(
      {required String userId,
      required String foodId,
      required String date,
      required String mealType}) async {
    try {
      await _usersCollection
          .doc(userId)
          .collection('foods')
          .doc(date)
          .collection(mealType)
          .doc(foodId)
          .delete();
    } catch (e) {
      log.e(e);
    }
  }
}
