import 'package:azsoon/Auth/SignIn.dart';
import 'package:azsoon/Auth/SignUp.dart';
import 'package:azsoon/Providers/DrawerNavProvider.dart';
import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/screens/CreateProfile.dart';
import 'package:flutter/material.dart';
import 'package:azsoon/screens/Home.dart';
import 'package:azsoon/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import './model/userinfoClass.dart';
import './Providers/userInfoProvider.dart';
import './widgets/Navigation-Drawer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => MoreInfoUserProvider()),
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: SplashScreen(),
      //SignUpScreen(),

      //  CreateProfileScreen(),
      routes: {
        'home': (context) => HomeScreen(),
        'signUp': (context) => SignUpScreen(),
        'signIn': (context) => SignInScreen(),
        'createProfile': (context) => CreateProfileScreen(),
      },
    );
  }
}
