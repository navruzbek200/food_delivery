import '../../../domain/entities/forgot_password_entity.dart';

class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState{}

class ForgotPasswordLoading extends ForgotPasswordState{}

class ForgotPasswordLoaded extends ForgotPasswordState{
  final ForgotPasswordEntity forgotPasswordEntity;

  ForgotPasswordLoaded({required this.forgotPasswordEntity});
}

class ForgotPasswordError extends ForgotPasswordState{
  final String message;

  ForgotPasswordError({required this.message});
}