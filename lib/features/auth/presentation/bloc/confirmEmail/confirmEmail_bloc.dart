import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/domain/usecases/confirm_email_usecase.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_delivery/features/auth/presentation/bloc/confirmEmail/confirmEmail_state.dart';
import 'package:logger/logger.dart';

class ConfirmEmailBloc extends Bloc<AuthEvent, ConfirmEmailState> {
  final ConfirmEmailUsecase confirmEmailUsecase;
  var logger = Logger();

  ConfirmEmailBloc({required this.confirmEmailUsecase}): super(ConfirmEmailInitial()){
    on<ConfirmEmailEvent>((event, emit)async {
      emit(ConfirmEmailLoading());
      try{
        final confirm = await confirmEmailUsecase.call(code: event.code);
        emit(ConfirmEmailLoaded(confirmEmailEntity: confirm));
      } catch(e,s){
        logger.e(s);
        emit(ConfirmEmailError(message: e.toString()));
      }
    },);
  }
}