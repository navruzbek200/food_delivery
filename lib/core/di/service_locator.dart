import 'package:food_delivery/features/auth/data/data_source/auth_remote_data_source_impl.dart';
import 'package:food_delivery/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_delivery/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:food_delivery/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:food_delivery/features/profile/data/data_source/profile_remote_data_soure_impl.dart';
import 'package:food_delivery/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:food_delivery/features/profile/domain/repositories/profile_repository.dart';
import 'package:food_delivery/features/profile/domain/usecases/logout_usecase.dart';
import 'package:food_delivery/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:food_delivery/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:food_delivery/features/auth/presentation/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resendCode/resend_code_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resetPassword/reset_password_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/confirm_email_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/confirmEmail/confirmEmail_bloc.dart';
import '../../features/auth/presentation/bloc/login/login_bloc.dart';
import '../../features/auth/presentation/bloc/register/register_bloc.dart';
import '../../features/profile/presentation/bloc/logout/logout_bloc.dart';
import '../network/dio_client.dart';
import '../utils/token_storage.dart';

final sl = GetIt.instance;
Future <void> setUp()async {
  sl.registerLazySingleton<DioClient>(() => DioClient(),);
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());

// Main
  sl.registerLazySingleton<AuthRemoteDataSource>(() {
    return AuthRemoteDataSourceImpl(dioClient: sl());
  },);

  sl.registerLazySingleton<AuthRepository>(() {
    return AuthRepositoryImpl(authRemoteDataSource: sl());
  },);

  sl.registerLazySingleton<ProfileRemoteDataSource>(() {
    return ProfileRemoteDataSoureImpl(
      dioClient: sl(),
      tokenStorage: sl(),);
  },);

  sl.registerLazySingleton<ProfileRepository>(() {
    return ProfileRepositoryImpl(profileRemoteDataSource: sl());
  },);


//  Usecases


  sl.registerLazySingleton<RegisterUsecase>(() {
    return RegisterUsecase(authRepository: sl());
  },);

  sl.registerLazySingleton<ConfirmEmailUsecase>(() {
    return ConfirmEmailUsecase(authRepository: sl());
  },);

  sl.registerLazySingleton<LoginUsecase>(() {
    return LoginUsecase(authRepository: sl());
  },);

  sl.registerLazySingleton<ForgotPasswordUsecase>(() {
    return ForgotPasswordUsecase(authRepository: sl());
  },);

  sl.registerLazySingleton<ResetPasswordUsecase>(() {
    return ResetPasswordUsecase(authRepository: sl());
  },);

  sl.registerLazySingleton<ResendCodeUsecase>(() {
    return ResendCodeUsecase(authRepository: sl());
  },);

  sl.registerLazySingleton<LogoutUsecase>(() {
    return LogoutUsecase(profileRepository: sl());
  },);


  // Bloc


  sl.registerFactory<RegisterBloc>(() {
    return RegisterBloc(registerUsecase: sl());
  },);

  sl.registerFactory<ConfirmEmailBloc>(() {
    return ConfirmEmailBloc(confirmEmailUsecase: sl());
  },);

  sl.registerFactory<LoginBloc>(() {
    return LoginBloc(loginUsecase: sl());
  },);

  sl.registerFactory<ForgotPasswordBloc>(() {
    return ForgotPasswordBloc(forgotPasswordUsecase: sl());
  },);

  sl.registerFactory<ResetPasswordBloc>(() {
    return ResetPasswordBloc(resetPasswordUsecase: sl());
  },);

  sl.registerFactory<ResendCodeBloc>(() {
    return ResendCodeBloc(resendCodeUsecase: sl());
  },);

  sl.registerFactory<LogoutBloc>(() {
    return LogoutBloc(logoutUsecase: sl());
  },);


}