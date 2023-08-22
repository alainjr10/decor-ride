import 'package:decor_ride/features/auth/data/models/user_model.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/domain/repository/register_repo.dart';

class RegisterUseCase {
  final RegisterRepo registerRepository;

  RegisterUseCase(this.registerRepository);

  Future<UserModel> call(CreateUserEntity createUserEntity) async {
    return await registerRepository
        .createUserWithEmailAndPassword(createUserEntity);
  }
}
