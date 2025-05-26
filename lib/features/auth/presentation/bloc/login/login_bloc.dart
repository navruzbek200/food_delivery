import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/domain/usecases/login_usecase.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_delivery/features/auth/presentation/bloc/login/login_state.dart';
import 'package:logger/logger.dart';

class LoginBloc extends Bloc<AuthEvent, LoginState> {
  final LoginUsecase loginUsecase;
  var logger = Logger();

  LoginBloc({required this.loginUsecase}): super(LoginInitial()){
    on<LoginEvent>((event, emit)async {
      emit(LoginLoading());
      try{
        final login = await loginUsecase.call(email: event.email, password: event.password);
        emit(LoginLoaded(loginEntity: login));
      }catch (e, s) {
        logger.e('Login failed:', error: e, stackTrace: s);
        emit(LoginError(message: e.toString()));
      }
    },);
  }
}