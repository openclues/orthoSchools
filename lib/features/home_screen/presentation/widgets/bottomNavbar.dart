// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// int _currentIndex = 0;

// var iconList = [Icons.home, Icons.person, Icons.settings];

// class _BottomNavState extends State<BottomNav> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () {
//           setState(() {
//             _currentIndex = 1;
//           });
//         },
//         child: const Icon(
//           Icons.edit,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: AnimatedBottomNavigationBar(
//         backgroundColor: Colors.black,
//         inactiveColor: Colors.blue,
//         activeColor: Colors.white,
//         gapLocation: GapLocation.center,
//         notchSmoothness: NotchSmoothness.verySmoothEdge,
//         icons: iconList,
//         activeIndex: _currentIndex,
//         onTap: (int) {
//           setState(() {
//             _currentIndex = int;
//           });
//         },
//       ),
//     );
//   }
// }
