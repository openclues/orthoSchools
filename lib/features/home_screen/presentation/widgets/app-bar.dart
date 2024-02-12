import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../Core/colors.dart';
import '../../../notifications/persentation/notifications_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(

      elevation: 0,
      centerTitle: true,
      backgroundColor: bodyColor,
      actions: [
        // IconButton(onPressed: () {}, icon: const Icon(IconlyLight.search)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(NotificationsScreen.routeName);
          },
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  IconlyLight.notification,
                ),
              ],
            ),
          ),
        ),
      ],
      title: Container(
        // height: 100,
        // color: primaryColor,
        child: Image.asset(
          'assets/images/11.png',
          height: kTextTabBarHeight * 1.5,
          // height: 3000,
        ),
      ));
}
