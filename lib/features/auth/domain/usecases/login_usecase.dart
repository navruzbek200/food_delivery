import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future call({required String email, required String password}) {
    return authRepository.login(email: email, password: password);
  }
}
