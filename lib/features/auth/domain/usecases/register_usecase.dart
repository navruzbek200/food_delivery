import 'package:food_delivery/features/auth/domain/entities/register_entity.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<RegisterEntity> call({
    required String email,
    required String password,
  }) {
    return authRepository.register(email: email, password: password);
  }
}
