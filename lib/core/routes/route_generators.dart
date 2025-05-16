import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/presentation/pages/onboarding/splash_screen.dart';
import '../../features/auth/presentation/pages/forgot_password/create_new_password.dart';
import '../../features/auth/presentation/pages/forgot_password/forgot_password.dart';
import '../../features/auth/presentation/pages/lets_in.dart';
import '../../features/auth/presentation/pages/login/login.dart';
import '../../features/auth/presentation/pages/onboarding/onboarding.dart';
import '../../features/auth/presentation/pages/onboarding/welcome.dart';
import '../../features/auth/presentation/pages/otp_verification/verificationScreen.dart';
import '../../features/auth/presentation/pages/signup/sign_up.dart';
import '../../features/home/presentation/pages/categories.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/search.dart';
import '../../features/home/presentation/pages/special_offers.dart';
import '../../features/likes/presentation/pages/liked_screen.dart';
import '../../features/notifications/presentation/pages/notification_screen.dart';
import '../../features/orders/presentation/pages/orders_screen.dart';
import '../../features/profile/presentation/pages/edit_profile_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import 'route_names.dart';

class AppRoute{
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash_screen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteNames.welcomeScreen:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case RouteNames.letsInScreen:
        return MaterialPageRoute(builder: (context) => LetsInScreen());
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteNames.verificationScreen:
        final aa = routeSettings.arguments as Map;
        return MaterialPageRoute(builder: (context) => VerificationScreen(purpose: aa["purpose"], verificationTarget: aa["VerificationTarget"],));
      case RouteNames.createNewPasswordScreen:
        return MaterialPageRoute(builder: (context) => CreateNewPasswordScreen());
      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RouteNames.searchScreen:
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case RouteNames.specialOffersPage:
        return MaterialPageRoute(builder: (context) => SpecialOffersPage());
      case RouteNames.categoriesScreen:
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      case RouteNames.likedScreen:
        final aa = routeSettings.arguments as List<Map <String, String>>;
        return MaterialPageRoute(builder: (context) => LikedScreen(allOffersDataRef: aa,));
      case RouteNames.notificationScreen:
        return MaterialPageRoute(builder: (context) => NotificationScreen());
      case RouteNames.ordersScreen:
        return MaterialPageRoute(builder: (context) => OrdersScreen());
      case RouteNames.profileScreen:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case RouteNames.editProfileScreen:
        return MaterialPageRoute(builder: (context) => EditProfileScreen());

      default:
        return _errorRoute();
    }
  }
    Route<dynamic> _errorRoute() {
      return MaterialPageRoute(builder: (context) =>
          Scaffold(
            appBar: AppBar(title: const Text("Error"),),
            body: const Center(child: Text("404 not found"),),
          ),);
    }
  
}