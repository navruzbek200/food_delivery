import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resetPassword/reset_password_state.dart';
import 'package:logger/logger.dart';


class ResetPasswordBloc extends Bloc<AuthEvent, ResetPasswordState> {
  final ResetPasswordUsecase resetPasswordUsecase;
  var logger = Logger();

  ResetPasswordBloc({required this.resetPasswordUsecase})
    : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        final resetPassword = await resetPasswordUsecase.call(
          email: event.email,
          password: event.password,
        );
        emit(ResetPasswordLoaded(resetPasswordEntity: resetPassword));
      } catch (e, s) {
        logger.e(s);
        emit(ResetPasswordError(message: e.toString()));
      }
    });
  }
}





