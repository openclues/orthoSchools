// import 'package:azsoon/Core/common-methods.dart';
// import 'package:azsoon/Providers/DrawerNavProvider.dart';
// import 'package:azsoon/Providers/userInfoProvider.dart';
// import 'package:azsoon/screens/CreateProfile.dart';
// import 'package:azsoon/screens/SplashScreen.dart';
// import 'package:azsoon/widgets/Post.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets/Navigation-Drawer.dart' as appdrawer;
// import '../widgets/PostTextfiled.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../widgets/App-bar.dart' as appBar;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late UserProvider _userProvider;

//   late DrawerProvider _drawerProvider;

//   @override
//   void initState() {
//     super.initState();
//     _userProvider = Provider.of<UserProvider>(context, listen: false);
//     _drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 230, 230, 230),
//       appBar: const appBar.AppBarWidget(),
//       drawer: appdrawer.NavigationDrawer(),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           child: const Column(children: [
//             SearchBarWidget(),
//             SizedBox(height: 15),
//             PostWidget(),
//           ]),
//         ),
//       ), //container colmun center insdie it search bar and post
//     );
//   }
// }
