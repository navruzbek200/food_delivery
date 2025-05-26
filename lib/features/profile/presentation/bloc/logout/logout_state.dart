import '../../../../profile/domain/entities/logout_entity.dart';

class LogoutState {}

class LogoutInitial extends LogoutState{}

class LogoutLoading extends LogoutState{}

class LogoutLoaded extends LogoutState{
  final LogoutEntity logoutEntity;

  LogoutLoaded({required this.logoutEntity});
}

class LogoutError extends LogoutState{
  final String message;

  LogoutError({required this.message});
}