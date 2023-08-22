import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/auth/data/data_sources/firebase_auth_api.dart';
import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';
import 'package:decor_ride/features/auth/domain/repository/register_repo.dart';
import 'package:decor_ride/features/auth/domain/repository/signin_repo.dart';

class AuthRepoImpl implements RegisterRepo, SignInRepo {
  final FirebaseAuthApi firebaseAuthApi;

  AuthRepoImpl({required this.firebaseAuthApi});
  @override
  Future<bool> checkIfUserExists(String email) {
    try {
      return firebaseAuthApi.checkIfUserExists(email);
    } catch (e, stackTrace) {
      "Error checking user exists: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      CreateUserEntity createUserEntity) {
    try {
      return firebaseAuthApi.createUserWithEmailAndPassword(createUserEntity);
    } catch (e, stackTrace) {
      "Error creating user: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }

  @override
  Future<String> getUid() {
    try {
      return firebaseAuthApi.getUid();
    } catch (e, stackTrace) {
      "Error getting uid: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      SigninUserEntity signInUserEntity) {
    try {
      return firebaseAuthApi.signInWithEmailAndPassword(signInUserEntity);
    } catch (e, stackTrace) {
      "Error signing in user: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    try {
      return firebaseAuthApi.signOut();
    } catch (e, stackTrace) {
      "Error signing out user: $e, With Stacktrace: $stackTrace".log();
      rethrow;
    }
  }
}
