import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase {
  final AuthRepository authRepository;

  ForgotPasswordUsecase({required this.authRepository});

  Future call({required String email}){
    return authRepository.forgotPassword(email: email);
  }
}