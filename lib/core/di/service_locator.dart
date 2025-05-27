import 'package:dio/dio.dart';
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
import '../../features/category/data/data_source/category_remote_data_source.dart';
import '../../features/category/data/repository/category_repository_impl.dart';
import '../../features/category/domain/repository/category_repository.dart';
import '../../features/category/domain/usecases/categories_usecase.dart';
import '../../features/category/domain/usecases/category_foods_usecase.dart';
import '../../features/category/presentation/bloc/categories/categories_bloc.dart';
import '../../features/category/presentation/bloc/category_foods/category_foods_bloc.dart';
import '../../features/category/presentation/bloc/singleCategory/single_category_bloc.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/create_order_usecase.dart';
import '../../features/home/presentation/bloc/create_order/create_order_bloc.dart';
import '../../features/orders/data/data_sources/orders_remote_datasource.dart';
import '../../features/orders/data/repositories/orders_repository_impl.dart';
import '../../features/orders/domain/repositories/orders_repository.dart';
import '../../features/orders/domain/usecases/active_orders_usecase.dart';
import '../../features/orders/domain/usecases/completed_orders_usecase.dart';
import '../../features/orders/domain/usecases/orders_usecase.dart';
import '../../features/orders/domain/usecases/update_orders_usecase.dart';
import '../../features/orders/presentation/bloc/active_order/active_order_bloc.dart';
import '../../features/orders/presentation/bloc/all_order/all_order_bloc.dart';
import '../../features/orders/presentation/bloc/completed_order/completed_order_bloc.dart';
import '../../features/orders/presentation/bloc/update_order/update_order_bloc.dart';
import '../../features/profile/presentation/bloc/logout/logout_bloc.dart';
import '../network/dio_client.dart';
import '../utils/token_storage.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Core dependencies
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(dioClient: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl()));

  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton<ConfirmEmailUsecase>(() => ConfirmEmailUsecase(authRepository: sl()));
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton<ForgotPasswordUsecase>(() => ForgotPasswordUsecase(authRepository: sl()));
  sl.registerLazySingleton<ResetPasswordUsecase>(() => ResetPasswordUsecase(authRepository: sl()));
  sl.registerLazySingleton<ResendCodeUsecase>(() => ResendCodeUsecase(authRepository: sl()));

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSoureImpl(dioClient: sl(), tokenStorage: sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(profileRemoteDataSource: sl()));
  sl.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(profileRepository: sl()));

  // Category
  sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(categoryRemoteDataSource: sl()));
  sl.registerLazySingleton<CategoriesUseCase>(() => CategoriesUseCase(categoryRepository: sl()));
  sl.registerLazySingleton<CategoryFoodsUsecase>(() => CategoryFoodsUsecase(categoryRepository: sl()));

  // Home
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDatasourceImpl(dio: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeRemoteDatasource: sl()));
  sl.registerLazySingleton<CreateOrderUseCase>(() => CreateOrderUseCase(homeRepository: sl()));

  // Orders
  sl.registerLazySingleton<OrdersRemoteDatasource>(() => OrdersRemoteDatasourceImpl(dio: sl()));
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(ordersRemoteDatasource: sl()));
  sl.registerLazySingleton<OrdersUsecase>(() => OrdersUsecase(ordersRepository: sl()));
  sl.registerLazySingleton<ActiveOrdersUseCase>(() => ActiveOrdersUseCase(ordersRepository: sl()));
  sl.registerLazySingleton<CompletedOrdersUseCase>(() => CompletedOrdersUseCase(ordersRepository: sl()));
  sl.registerLazySingleton<UpdateOrdersUsecase>(() => UpdateOrdersUsecase(ordersRepository: sl()));

  // Blocs: Auth
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(registerUsecase: sl()));
  sl.registerFactory<ConfirmEmailBloc>(() => ConfirmEmailBloc(confirmEmailUsecase: sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(loginUsecase: sl()));
  sl.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(forgotPasswordUsecase: sl()));
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(resetPasswordUsecase: sl()));
  sl.registerFactory<ResendCodeBloc>(() => ResendCodeBloc(resendCodeUsecase: sl()));

  // Bloc: Profile
  sl.registerFactory<LogoutBloc>(() => LogoutBloc(logoutUsecase: sl()));

  // Bloc: Orders
  sl.registerFactory<AllOrderBloc>(() => AllOrderBloc(ordersUsecase: sl()));
  sl.registerFactory<ActiveOrderBloc>(() => ActiveOrderBloc(activeOrdersUseCase: sl()));
  sl.registerFactory<CompletedOrderBloc>(() => CompletedOrderBloc(completedOrdersUseCase: sl()));
  sl.registerFactory<UpdateOrderBloc>(() => UpdateOrderBloc(updateOrdersUsecase: sl()));

  // Bloc: Home
  sl.registerFactory<CreateOrderBloc>(() => CreateOrderBloc(createOrderUseCase: sl()));

  // Bloc: Category
  sl.registerFactory<CategoriesBloc>(() => CategoriesBloc(categoriesUseCase: sl()));
  sl.registerFactory<SingleCategoryBloc>(() => SingleCategoryBloc(singleCategoryUseCase: sl())); // Make sure this usecase exists
  sl.registerFactory<CategoryFoodsBloc>(() => CategoryFoodsBloc(categoryFoodsUseCase: sl()));
}
