import 'package:flutter/material.dart';
import 'package:kawika_test/controllers/home_controllers.dart';
import 'package:kawika_test/controllers/login_controller.dart';
import 'package:kawika_test/controllers/profile_controller.dart';
import 'package:kawika_test/pages/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider<HomeControllers>(
          create: (context) => HomeControllers(),
        ),
        ChangeNotifierProvider<ProfileController>(
          create: (context) => ProfileController(),
        ),
      ],
      child: MaterialApp(
        home: const Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
