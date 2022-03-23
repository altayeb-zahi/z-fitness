import '../models/user.dart';

abstract class FirestoreApiAbstract {
  Future<User?> getUser({required String userId});

  Future<void> createUser({required User user});

  Future<void> updateUser({required User user});
}