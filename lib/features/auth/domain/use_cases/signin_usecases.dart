import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';
import 'package:decor_ride/features/auth/domain/repository/signin_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final registerRepo = ref.watch(authRepoImplProvider);
  return SignInUseCase(registerRepo);
});

class SignInUseCase {
  final SignInRepo registerRepository;

  SignInUseCase(this.registerRepository);

  Future<Either<String, UserModel>> call(SigninUserEntity params) async {
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
