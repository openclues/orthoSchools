import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Common.dart';
import 'Home.dart';
import '../Auth/SignIn.dart'; //on bording
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final ROUTE_NAME = 'splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? val = pref.getString('login');
      if (val != null) {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Image.asset(
            'assets/images/Square.png',
            width: 90,
          ),
          // Lottie.asset('assets/json-files/loaderOrthoschools.json'),
          //CircularProgressIndicator( //image instead
          //   backgroundColor: Colors.blue,
          // ),
        ));
  }
}
