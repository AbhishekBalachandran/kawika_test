import 'package:flutter/material.dart';
import 'package:kawika_test/models/user_model.dart';
import 'package:kawika_test/pages/login/login.dart';
import 'package:kawika_test/pages/navigation_menu/navigation_menu.dart';
import 'package:kawika_test/preferences/preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 1));
    final UserDataModel? userData = await Preferences().getUserData();
    if (!mounted) return;

    if (userData != null &&
        userData.accessToken != null &&
        userData.accessToken!.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationMenu()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
