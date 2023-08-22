import 'package:decor_ride/features/auth/domain/repository/register_repo.dart';

class CheckUserEmailUseCase {
  final RegisterRepo registerRepository;

  CheckUserEmailUseCase(this.registerRepository);

  Future<bool> call(String email) async {
    return await registerRepository.checkIfUserExists(email);
  }
}
