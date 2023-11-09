import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import '../widgets/AppBar.dart' as appdrawer;
import '../widgets/PostTextfiled.dart';

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
        backgroundColor: Color(0XFF2F7EDB),
        title: Text('ORTH-UNI'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/bell.png',
              width: 25,
            ),
          ),
        ],
      ),
      drawer: appdrawer.NavigationDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            SearchBarWidget(),
            SizedBox(height: 15), // Add space between widgets
            PostWidget(),
          ]),
        ),
      ), //container colmun center insdie it search bar and post
    );
  }
}
