import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/di/service_locator.dart';
import 'package:food_delivery/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_foods/category_foods_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/singleCategory/single_category_bloc.dart';
import 'package:food_delivery/features/home/presentation/bloc/create_order/create_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/active_order/active_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/all_order/all_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/completed_order/completed_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/update_order/update_order_bloc.dart';
import 'features/my_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AllOrderBloc>()),
        BlocProvider(create: (context) => sl<ActiveOrderBloc>()),
        BlocProvider(create: (context) => sl<CompletedOrderBloc>()),
        BlocProvider(create: (context) => sl<UpdateOrderBloc>()),
        BlocProvider(create: (context) => sl<CreateOrderBloc>()),
        BlocProvider(create: (context) => sl<CategoriesBloc>()),
        BlocProvider(create: (context) => sl<SingleCategoryBloc>()),
        BlocProvider(create: (context) => sl<CategoryFoodsBloc>()),

      ],
      child: const MyApp()
  ));
}
