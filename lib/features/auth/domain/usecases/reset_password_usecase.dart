import 'package:food_delivery/features/auth/domain/entities/reset_password_entity.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});

  Future<ResetPasswordEntity> call({
    required String email,
    required String password,
  }) {
    return authRepository.resetPassword(email: email, password: password);
  }
}
