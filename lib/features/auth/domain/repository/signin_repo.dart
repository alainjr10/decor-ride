import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';

abstract class SignInRepo {
  Future<UserModel> signInWithEmailAndPassword(
      SigninUserEntity signInUserEntity);
  Future<void> signOut();
  Future<String> getUid();
}
