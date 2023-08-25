import 'package:decor_ride/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:decor_ride/features/auth/domain/repository/register_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkUserEmailUseCaseProvider = Provider<CheckUserEmailUseCase>((ref) {
  final registerRepo = ref.watch(authRepoImplProvider);
  return CheckUserEmailUseCase(registerRepo);
});

class CheckUserEmailUseCase {
  final RegisterRepo registerRepository;

  CheckUserEmailUseCase(this.registerRepository);

  Future<bool> call(String email) async {
    return await registerRepository.checkIfUserExists(email);
  }
}
