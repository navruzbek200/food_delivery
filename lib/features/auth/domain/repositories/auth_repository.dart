import 'package:food_delivery/features/auth/domain/entities/confirm_email_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/login_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/register_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/resend_code_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/reset_password_entity.dart';

abstract class AuthRepository {

  Future<RegisterEntity> register({required String email, required String password});

  Future<ConfirmEmailEntity> confirmEmail({required int code});

  Future<LoginEntity> login({required String email, required String password});

  Future<ForgotPasswordEntity> forgotPassword({required String email});

  Future<ResetPasswordEntity> resetPassword({required String email, required String password});

  Future<ResendCodeEntity> resendCode({required String email});

}


