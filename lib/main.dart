import 'package:azsoon/screens/SignIn.dart';
import 'package:azsoon/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:azsoon/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: debugDisableShadows,
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      home: HomeScreen(),
      routes: {
        'signUp': (context) => SignUpScreen(),
        'signIn': (context) => SignInScreen(),
      },
    );
  }
}
