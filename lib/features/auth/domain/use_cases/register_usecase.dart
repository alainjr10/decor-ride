import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/domain/repository/register_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final registerRepo = ref.watch(authRepoImplProvider);
  return RegisterUseCase(registerRepo);
});

class RegisterUseCase {
  final RegisterRepo registerRepository;

  RegisterUseCase(this.registerRepository);

  Future<Either<String, UserModel>> call(
      CreateUserEntity createUserEntity) async {
    return await registerRepository
        .createUserWithEmailAndPassword(createUserEntity);
  }
}
