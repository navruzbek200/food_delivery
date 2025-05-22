import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import 'auth/presentation/pages/onboarding/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (builderContext) {
          AppResponsive.init(builderContext);

          return MaterialApp(
            title: 'Speedy Chow',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              fontFamily: 'Roboto',
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
    );
  }
}