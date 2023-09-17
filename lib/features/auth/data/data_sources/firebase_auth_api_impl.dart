import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/features/auth/data/data_sources/firebase_auth_api.dart';
import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthApiProvider = Provider<FirebaseAuthApiImpl>((ref) {
  return FirebaseAuthApiImpl();
});

class FirebaseAuthApiImpl implements FirebaseAuthApi {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> checkIfUserExists(String email) async {
    try {
      final userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return userSnapshot.docs.isNotEmpty;
    } catch (e, stackTrace) {
      "Error checking user exists: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }

  @override
  Future<Either<String, UserModel>> createUserWithEmailAndPassword(
      CreateUserEntity createUserEntity) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: createUserEntity.email, password: createUserEntity.password);
      final user = userCredential.user!;
      Map<String, dynamic> updatedMap = {
        ...createUserEntity.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'userId': user.uid,
      };
      await _firestore.collection('users').doc(user.uid).set(
            updatedMap,
          );
      await user.updateDisplayName('firstName');
      return right(UserModel.fromJson(updatedMap));
    } on FirebaseAuthException catch (e, stackTrace) {
      "Error creating user: $e, With Stacktrace: $stackTrace".log();
      return left(e.message ?? 'An error occurred creating user');
    }
  }

  @override
  Future<Either<String, UserModel>> signInWithEmailAndPassword(
      SigninUserEntity signInUserEntity) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: signInUserEntity.email, password: signInUserEntity.password);
      final user = userCredential.user!;
      final userSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      return right(UserModel.fromMap(userSnapshot.data()!));
    } on FirebaseAuthException catch (e, stackTrace) {
      "Error signing in user: $e, With Stacktrace: $stackTrace".log();
      return left(e.message ?? 'An error occurred signing in user');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, stackTrace) {
      "Error signing out user: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }

  @override
  Future<String> getUid() async {
    try {
      final user = _auth.currentUser!;
      return user.uid;
    } catch (e, stackTrace) {
      "Error getting user uid: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }
}
