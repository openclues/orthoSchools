import 'package:azsoon/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/bloc/profile_bloc.dart';
import 'search_filter_wigdet.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Hi, ${context.read<ProfileBloc>().state is ProfileLoaded ? (context.read<ProfileBloc>().state as ProfileLoaded).profileModel.user!.firstName : ''}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: MyprofileImage(),
            ),
          ],
        ),
        const SearchAndFilterWidget()
      ],
    );
  }
}

class MyprofileImage extends StatelessWidget {
  const MyprofileImage({super.key});

  @override
  Widget build(BuildContext context) {
    String? image = (context.read<ProfileBloc>().state as ProfileLoaded)
        .profileModel
        .profileImage;
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProfilePage.routeName, arguments: {
            'userId': (context.read<ProfileBloc>().state as ProfileLoaded)
                .profileModel
                .user!
                .id,
            "isNav": false
          });
        },
        child: image != null
            ? CircleAvatar(radius: 30, backgroundImage: NetworkImage(image))
            : CircleAvatar(
                radius: 30, child: Image.asset('assets/images/drimage.png')));
  }
}

//search and filter
