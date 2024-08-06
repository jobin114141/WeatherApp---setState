import 'package:flutter/material.dart';
import 'package:myweatherapp/views/LoginPage.dart';
import 'package:myweatherapp/views/weatherPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool("isLoggedIn"));
    return prefs.getBool("isLoggedIn") ?? false; // Default to false if not set
  }

  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLogin(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Loading indicator while checking login status
        } else {
          bool loggedIn = snapshot.data ?? false;
          return loggedIn
              ? WeatherPage()
              : Loginpage(); // Navigate based on login status
        }
      },
    );
  }
}
