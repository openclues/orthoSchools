import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/screens/CreateProfile.dart';
import 'package:azsoon/screens/SplashScreen.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import '../widgets/AppBar.dart' as appdrawer;
import '../widgets/PostTextfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0XFF005F7E)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'ORTH-UNI',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                //navigatie to notificaitons
              },
              icon: Icon(Icons.notifications)),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Image.asset(
          //     'assets/images/bell.png',
          //     width: 25,
          //   ),
          // ),
          IconButton(
              onPressed: () async {
                await CommonMethods.logOut();
                if (context.mounted) {
                  //to make sure that the logout await is done
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                      (route) => false);
                }
              },
              icon: Icon(Icons.login)),
          IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('createProfile');
              },
              icon: Icon(
                Icons.person,
                color: Color(0XFF005F7E),
              )),
        ],
      ),
      drawer: appdrawer.NavigationDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            SearchBarWidget(),
            SizedBox(height: 15),
            PostWidget(),
          ]),
        ),
      ), //container colmun center insdie it search bar and post
    );
  }
}
