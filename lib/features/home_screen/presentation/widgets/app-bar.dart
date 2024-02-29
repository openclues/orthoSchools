import 'package:azsoon/features/dashboard/presentation/dashboard_screen.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../../Core/colors.dart';
import '../../../notifications/persentation/notifications_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: bodyColor,
      leading: (context.read<ProfileBloc>().state is ProfileLoaded &&
              (context.read<ProfileBloc>().state as ProfileLoaded)
                  .profileModel
                  .user!
                  .groups!
                  .isNotEmpty)
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DashBoardScreen.routeName);
              },
              icon: const Icon(
                IconlyBold.activity,
                size: 30,
                color: primaryColor,
              ))
          : null,
      actions: [
        // IconButton(onPressed: () {}, icon: const Icon(IconlyLight.search)),

        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(NotificationsScreen.routeName);
              },
              // ignore: prefer_const_constructors
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state is ProfileLoaded &&
                        (state).profileModel.notificationsCount! > 0)
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: primaryColor,
                        child: Text(
                          '${(state).profileModel.notificationsCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const Icon(
                      IconlyLight.notification,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
      title: Image.asset(
        'assets/images/11.png',
        height: kTextTabBarHeight * 1.5,
        // height: 3000,
      ));
}
