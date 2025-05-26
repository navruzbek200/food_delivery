import '../../../domain/entities/reset_password_entity.dart';

class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState{}

class ResetPasswordLoading extends ResetPasswordState{}

class ResetPasswordLoaded extends ResetPasswordState{
  final ResetPasswordEntity resetPasswordEntity;

  ResetPasswordLoaded({required this.resetPasswordEntity});
}

class ResetPasswordError extends ResetPasswordState{
  final String message;

  ResetPasswordError({required this.message});
}