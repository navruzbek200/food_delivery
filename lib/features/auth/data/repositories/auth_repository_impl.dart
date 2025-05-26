import 'package:food_delivery/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:food_delivery/features/auth/domain/entities/confirm_email_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/login_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/register_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/resend_code_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/reset_password_entity.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<RegisterEntity> register({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.register(email: email, password: password);
  }

  @override
  Future<ConfirmEmailEntity> confirmEmail({required int code}) {
    return authRemoteDataSource.confirmEmail(code: code);
  }

  @override
  Future<LoginEntity> login({required String email, required String password}) {
    return authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<ForgotPasswordEntity> forgotPassword({required String email}) {
    return authRemoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<ResetPasswordEntity> resetPassword({required String email, required String password}) {
    return authRemoteDataSource.resetPassword(email: email, password: password);
  }

  @override
  Future<ResendCodeEntity> resendCode({required String email}) {
    return authRemoteDataSource.resendCode(email: email);
  }

}
