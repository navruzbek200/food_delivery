import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/domain/usecases/register_usecase.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_delivery/features/auth/presentation/bloc/register/register_state.dart';
import 'package:logger/logger.dart';

class RegisterBloc extends Bloc<AuthEvent, RegisterState> {
  final RegisterUsecase registerUsecase;
  var logger = Logger();

  RegisterBloc({required this.registerUsecase}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final register = await registerUsecase.call(
          email: event.email,
          password: event.password,
        );
        emit(RegisterLoaded(registerEntity: register));
      } catch (e, s) {
        logger.e(s);
        emit(RegisterError(message: e.toString()));
      }
    });
  }
}
