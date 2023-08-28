import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';

abstract class RegisterRepo {
  Future<Either<String, UserModel>> createUserWithEmailAndPassword(
      CreateUserEntity createUserEntity);
  Future<bool> checkIfUserExists(String email);
}
