import 'package:flutter/material.dart';
import 'auth/presentation/pages/onboarding/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedy Chow',
      theme: ThemeData(
        primarySwatch: Colors.orange,

      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,

      // },
    );
  }
}