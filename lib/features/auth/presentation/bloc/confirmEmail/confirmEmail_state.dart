import '../../../domain/entities/confirm_email_entity.dart';

class ConfirmEmailState {}

class ConfirmEmailInitial extends ConfirmEmailState{}

class ConfirmEmailLoading extends ConfirmEmailState{}

class ConfirmEmailLoaded extends ConfirmEmailState{
  final ConfirmEmailEntity confirmEmailEntity;

  ConfirmEmailLoaded({required this.confirmEmailEntity});
}

class ConfirmEmailError extends ConfirmEmailState{
  final String message;

  ConfirmEmailError({required this.message});
}