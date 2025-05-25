import 'package:dio/dio.dart';
import 'package:food_delivery/features/category/data/data_source/category_remote_data_source.dart';
import 'package:food_delivery/features/category/data/repository/category_repository_impl.dart';
import 'package:food_delivery/features/category/domain/repository/category_repository.dart';
import 'package:food_delivery/features/category/domain/usecases/categories_usecase.dart';
import 'package:food_delivery/features/category/domain/usecases/category_foods_usecase.dart';
import 'package:food_delivery/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_foods/category_foods_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/singleCategory/single_category_bloc.dart';
import 'package:food_delivery/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:food_delivery/features/home/data/repositories/home_repository_impl.dart';
import 'package:food_delivery/features/home/domain/repositories/home_repository.dart';
import 'package:food_delivery/features/home/domain/usecases/create_order_usecase.dart';
import 'package:food_delivery/features/home/presentation/bloc/create_order/create_order_bloc.dart';
import 'package:food_delivery/features/orders/data/data_sources/orders_remote_datasource.dart';
import 'package:food_delivery/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:food_delivery/features/orders/domain/repositories/orders_repository.dart';
import 'package:food_delivery/features/orders/domain/usecases/active_orders_usecase.dart';
import 'package:food_delivery/features/orders/domain/usecases/completed_orders_usecase.dart';
import 'package:food_delivery/features/orders/domain/usecases/orders_usecase.dart';
import 'package:food_delivery/features/orders/domain/usecases/update_orders_usecase.dart';
import 'package:food_delivery/features/orders/presentation/bloc/active_order/active_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/all_order/all_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/completed_order/completed_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/update_order/update_order_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setup()async{
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<OrdersRemoteDatasource>(() => OrdersRemoteDatasourceImpl(dio: sl()));
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(ordersRemoteDatasource: sl()));

  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDatasourceImpl(dio: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeRemoteDatasource: sl()));

  sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(categoryRemoteDataSource: sl()));

  sl.registerLazySingleton<OrdersUsecase>(() => OrdersUsecase(ordersRepository: sl()));
  sl.registerLazySingleton<ActiveOrdersUseCase>(() => ActiveOrdersUseCase(ordersRepository: sl()));
  sl.registerLazySingleton<CompletedOrdersUseCase>(() => CompletedOrdersUseCase(ordersRepository: sl()));
  sl.registerLazySingleton<UpdateOrdersUsecase>(() => UpdateOrdersUsecase(ordersRepository: sl()));

  sl.registerLazySingleton<CreateOrderUseCase>(() => CreateOrderUseCase(homeRepository: sl()));
  sl.registerLazySingleton<CategoriesUseCase>(() => CategoriesUseCase(categoryRepository: sl()));
  sl.registerLazySingleton<CategoryFoodsUsecase>(() => CategoryFoodsUsecase(categoryRepository: sl()));


  sl.registerFactory<AllOrderBloc>(() => AllOrderBloc(ordersUsecase: sl()));
  sl.registerFactory<ActiveOrderBloc>(() => ActiveOrderBloc(activeOrdersUseCase: sl()));
  sl.registerFactory<CompletedOrderBloc>(() => CompletedOrderBloc(completedOrdersUseCase: sl()));
  sl.registerFactory<UpdateOrderBloc>(() => UpdateOrderBloc(updateOrdersUsecase: sl()));

  sl.registerFactory<CreateOrderBloc>(() => CreateOrderBloc(createOrderUseCase: sl()));
  sl.registerFactory<CategoriesBloc>(() => CategoriesBloc(categoriesUseCase: sl()));
  sl.registerFactory<SingleCategoryBloc>(() => SingleCategoryBloc(singleCategoryUseCase: sl()));
  sl.registerFactory<CategoryFoodsBloc>(() => CategoryFoodsBloc(categoryFoodsUseCase: sl()));

}