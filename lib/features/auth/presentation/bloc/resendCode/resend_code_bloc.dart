import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resendCode/resend_code_state.dart';
import 'package:logger/logger.dart';

class ResendCodeBloc extends Bloc<AuthEvent, ResendCodeState> {
  final ResendCodeUsecase resendCodeUsecase;
  var logger = Logger();

  ResendCodeBloc({required this.resendCodeUsecase})
    : super(ResendCodeInitial()) {
    on<ResendCodeEvent>((event, emit) async {
      emit(ResendCodeLoading());
      try {
        final resendCode = await resendCodeUsecase.call(email: event.email);
        emit(ResendCodeLoaded(resendCodeEntity: resendCode));
      } catch (e, s) {
        logger.e(s);
        emit(ResendCodeError(message: e.toString()));
      }
    });
  }
}


