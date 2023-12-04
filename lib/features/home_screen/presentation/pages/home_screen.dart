import 'package:azsoon/Core/colors.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatelessWidget {
  static const  String routeName = '/home';
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(children: [
            TextButton(
                onPressed: () {},
                child: const Text('Home',
                    style: TextStyle(color: primaryColor, fontSize: 18))),
            //tabs
          ]),
        ),
        backgroundColor: primaryColor,
        title: const Text('HomeScreenPage'),
      ),
      body: const Center(
        child: Text('HomeScreenPage is working'),
      ),
    );
  }
}
