import '../../../domain/entities/resend_code_entity.dart';

class ResendCodeState {}

class ResendCodeInitial extends ResendCodeState{}

class ResendCodeLoading extends ResendCodeState{}

class ResendCodeLoaded extends ResendCodeState{
  final ResendCodeEntity resendCodeEntity;

  ResendCodeLoaded({required this.resendCodeEntity});
}

class ResendCodeError extends ResendCodeState{
  final String message;

  ResendCodeError({required this.message});
}