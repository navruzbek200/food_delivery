import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/profile/domain/usecases/logout_usecase.dart';
import 'package:food_delivery/features/profile/presentation/bloc/logout/logout_state.dart';
import 'package:food_delivery/features/profile/presentation/bloc/profile_event.dart';
import 'package:logger/logger.dart';

class LogoutBloc extends Bloc<ProfileEvent, LogoutState> {
  final LogoutUsecase logoutUsecase;
  var logger = Logger();

  LogoutBloc({required this.logoutUsecase}) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      try {
        final logout = await logoutUsecase.call();
        emit(LogoutLoaded(logoutEntity: logout));
      } catch (e, s) {
        logger.e(s);
        emit(LogoutError(message: e.toString()));
      }
    });
  }
}
