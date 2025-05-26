import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/confirmEmail/confirmEmail_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resendCode/resend_code_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resetPassword/reset_password_bloc.dart';
import 'package:food_delivery/features/profile/presentation/pages/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/service_locator.dart';
import 'features/auth/presentation/bloc/register/register_bloc.dart';
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
import 'features/profile/presentation/bloc/logout/logout_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();
  await setUp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => sl<RegisterBloc>(),),
    BlocProvider(create: (context) => sl<ConfirmEmailBloc>(),),
    BlocProvider(create: (context) => sl<LoginBloc>(),),
    BlocProvider(create: (context) => sl<ForgotPasswordBloc>(),),
    BlocProvider(create: (context) => sl<ResetPasswordBloc>(),),
    BlocProvider(create: (context) => sl<ResendCodeBloc>(),),
    BlocProvider(create: (context) => sl<LogoutBloc>(), child: ProfileScreen(),),
  ], child: const MyApp()));

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
