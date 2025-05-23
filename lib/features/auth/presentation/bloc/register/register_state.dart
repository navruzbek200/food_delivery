import '../../../domain/entities/register_entity.dart';

class RegisterState {}

class RegisterInitial extends RegisterState{}

class RegisterLoading extends RegisterState{}

class RegisterLoaded extends RegisterState{
  final RegisterEntity registerEntity;

  RegisterLoaded({required this.registerEntity});
}

class RegisterError extends RegisterState{
  final String message;
  final String? code;

  RegisterError({required this.message, this.code});
}