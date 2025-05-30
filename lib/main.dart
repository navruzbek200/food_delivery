import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/service_locator.dart';
import 'features/my_app.dart';

// Auth and Profile blocs
import 'package:food_delivery/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/confirmEmail/confirmEmail_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resetPassword/reset_password_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resendCode/resend_code_bloc.dart';
import 'package:food_delivery/features/profile/presentation/bloc/logout/logout_bloc.dart';

// Category, Orders, Home blocs
import 'package:food_delivery/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_foods/category_foods_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/singleCategory/single_category_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/all_order/all_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/active_order/active_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/completed_order/completed_order_bloc.dart';
import 'package:food_delivery/features/orders/presentation/bloc/update_order/update_order_bloc.dart';
import 'package:food_delivery/features/home/presentation/bloc/create_order/create_order_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await setup();

  runApp(
    MultiBlocProvider(
      providers: [
        // Auth & Profile
        BlocProvider(create: (_) => sl<RegisterBloc>()),
        BlocProvider(create: (_) => sl<ConfirmEmailBloc>()),
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider(create: (_) => sl<ForgotPasswordBloc>()),
        BlocProvider(create: (_) => sl<ResetPasswordBloc>()),
        BlocProvider(create: (_) => sl<ResendCodeBloc>()),
        BlocProvider(create: (_) => sl<LogoutBloc>()),

        // Orders
        BlocProvider(create: (_) => sl<AllOrderBloc>()),
        BlocProvider(create: (_) => sl<ActiveOrderBloc>()),
        BlocProvider(create: (_) => sl<CompletedOrderBloc>()),
        BlocProvider(create: (_) => sl<UpdateOrderBloc>()),

        // Category & Home
        BlocProvider(create: (_) => sl<CreateOrderBloc>()),
        BlocProvider(create: (_) => sl<CategoriesBloc>()),
        BlocProvider(create: (_) => sl<SingleCategoryBloc>()),
        BlocProvider(create: (_) => sl<CategoryFoodsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
