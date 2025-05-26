import 'package:food_delivery/features/auth/domain/entities/resend_code_entity.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class ResendCodeUsecase {
  final AuthRepository authRepository;

  ResendCodeUsecase({required this.authRepository});

  Future<ResendCodeEntity>call({required String email,}){
    return authRepository.resendCode(email: email);
  }
}