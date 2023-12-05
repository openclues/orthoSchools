import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/Navigation-Drawer.dart' as appdrawer;
import '../widgets/app-bar.dart';

class HomeScreenPage extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

int _currentIndex = 0;

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 242, 242, 242),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.edit,
            ),
            backgroundColor: Colors.amber,
            onPressed: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            backgroundColor: Colors.black,
            inactiveColor: Colors.blue,
            activeColor: Colors.white,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            icons: [Icons.home, Icons.person, Icons.settings, Icons.settings],
            activeIndex: 0,
            onTap: (index) {},
          ),
          appBar: buildAppBar(),
          drawer: appdrawer.NavigationDrawer(),
          body: ListView(
            children: [
              SpacesList(),
              // PostWidget(),
            ],
          )),
    );
  }
}
