import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:logger/logger.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<AuthEvent, ForgotPasswordState> {
  final ForgotPasswordUsecase forgotPasswordUsecase;
  var logger = Logger();

  ForgotPasswordBloc({required this.forgotPasswordUsecase}): super(ForgotPasswordInitial()){
    on<ForgotPasswordEvent>((event, emit)async {
      emit(ForgotPasswordLoading());
      try{
        final forgotPassword = await forgotPasswordUsecase.call(email: event.email);
        emit(ForgotPasswordLoaded(forgotPasswordEntity: forgotPassword));
      } catch(e,s){
        logger.e(s);
        emit(ForgotPasswordError(message: e.toString()));
      }
    },);
  }
}