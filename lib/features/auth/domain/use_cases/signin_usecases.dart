import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';
import 'package:decor_ride/features/auth/domain/repository/signin_repo.dart';

class SignInUseCase {
  final SignInRepo registerRepository;

  SignInUseCase(this.registerRepository);

  Future<UserModel> call(SigninUserEntity params) async {
    return await registerRepository.signInWithEmailAndPassword(params);
  }
}

class SignOutUseCase {
  final SignInRepo registerRepository;

  SignOutUseCase(this.registerRepository);

  Future<void> call() async {
    return await registerRepository.signOut();
  }
}

class GetUidUseCase {
  final SignInRepo registerRepository;

  GetUidUseCase(this.registerRepository);

  Future<String> call() async {
    return await registerRepository.getUid();
  }
}
