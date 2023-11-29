import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Common.dart';
import 'Home.dart';
import '../Auth/SignIn.dart'; //on bording
import 'package:lottie/lottie.dart';
import '../Core/common-methods.dart';
import 'package:http/http.dart' as http;

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
      String? val = pref.getString('login'); //
      if (val != null) {
        //the endpoint will take the token only (login)
        ///request user data from the endpoint if status code 200, 201 idk which one yet => go to home and display data in there place
        /////if 403 this token has a problem so redirect to login screen to make new token
        ///
        String? authToken = await CommonMethods.getAuthToken();
        try {
          final response = await http.get(
            Uri.parse('https://orthoschools.com/user/info'),
            headers: {
              'Authorization': 'Token $authToken',
            },
          );

          if (response.statusCode == 200) {
            // If the server returns a 200 OK response, parse the JSON
            final Map<String, dynamic> data = json.decode(response.body);
            print(data);
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            // If the server did not return a 200 OK response, throw an exception.
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => SignInScreen()));
            throw Exception('Failed to load user info');
          }
        } catch (e) {
          // Handle potential exceptions, such as network errors.
          print('Error: $e');
          rethrow;
        }
        // try {
        //   // final Map<String, dynamic> userInfo =
        //   //     await CommonMethods.getUserInfo(authToken!);
        //   // print(userInfo);

        //   // Use the user information as needed
        // } catch (e) {
        //   // Handle errors
        //   print('Error fetching user info: $e');
        // }
      } else {
        //delete login
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
