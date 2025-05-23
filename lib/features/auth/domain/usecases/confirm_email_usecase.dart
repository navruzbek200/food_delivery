import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class ConfirmEmailUsecase {
  final AuthRepository authRepository;

  ConfirmEmailUsecase({required this.authRepository});

  Future call({required int code}){
    return authRepository.confirmEmail(code: code);
  }
}