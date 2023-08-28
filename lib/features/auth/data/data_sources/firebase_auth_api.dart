import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';

abstract class FirebaseAuthApi {
  Future<Either<String, UserModel>> signInWithEmailAndPassword(
      SigninUserEntity signInUserEntity);
  Future<Either<String, UserModel>> createUserWithEmailAndPassword(
      CreateUserEntity createUserEntity);
  Future<bool> checkIfUserExists(String email);
  Future<void> signOut();
  Future<String> getUid();
}
