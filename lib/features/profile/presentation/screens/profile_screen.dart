import 'dart:math';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  final bool? isNav;
  final int? userId;
  const ProfileScreen({super.key, this.isNav, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    buildProfile(context);
    var profilestate = context.watch<ProfileBloc>().state;
    buildListners(profilestate);

    return Scaffold(
      appBar: widget.isNav == true
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title:
                  const Text('Profile', style: TextStyle(color: primaryColor)),
            )
          : null,
      body: ProfileScreenData(profilestate: profilestate),
    );
  }

  void buildProfile(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfileData(id: widget.userId));
  }

  void buildListners(ProfileState state) {
    if (state is ProfileError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class ProfileScreenData extends StatelessWidget {
  final ProfileState profilestate;
  const ProfileScreenData({super.key, required this.profilestate});

  @override
  Widget build(BuildContext context) {
    if (profilestate is ProfileLoading || profilestate is ProfileInitial) {
      return const LoadingWidget();
    } else if (profilestate is ProfileLoaded) {
      return ProfileLoadedWidget(
          profileModel: (profilestate as ProfileLoaded).profileModel);
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}

class LoadinfWidget extends StatelessWidget {
  const LoadinfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }
}

class ProfileLoadedWidget extends StatelessWidget {
  final Profile? profileModel;
  const ProfileLoadedWidget({super.key, this.profileModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/cover.jpg',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          IconlyBold.edit,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Stack(
                  children: [
                    //edit
                    Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 10)
                      ], color: Colors.white, shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/drimage.png',
                        ),
                      ),
                    ),
                    if (profileModel!.isme == true)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconlyBold.edit,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                " ${profileModel!.title ?? ""}${profileModel!.user!.firstName} ${profileModel!.user!.lastName}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(width: 10),
              if (profileModel!.user!.userRole == 2)
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0.5),
                            blurRadius: 1)
                      ],
                    ),
                    child:
                        Image.asset('assets/images/premium.png', height: 25)),
              const SizedBox(width: 5),
              if (profileModel!.user!.isVerifiedPro == true)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0.5),
                          blurRadius: 1)
                    ],
                  ),
                  child: Image.asset('assets/images/verified-account.png',
                      height: 25),
                ),
              const Spacer(),
            ],
          ),
        ),
        // const SizedBox(height: 10),
        ProfileMoreInfo(profileModel: profileModel!),
        //bio
        if (profileModel!.bio != null && profileModel!.bio!.isNotEmpty)
          // const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'I am a Flutter developer with 2 years of experience in mobile development',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {},
              child: const Text('Edit Profile')),
        ),

        // tabs bar
      ],
    );
  }
}

class ProfileMoreInfo extends StatelessWidget {
  final Profile profileModel;
  const ProfileMoreInfo({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (profileModel!.placeOfWork != null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(
                        IconlyBold.work,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: 5),
                      Text("Place of work")
                    ],
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${profileModel!.placeOfWork}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          if (profileModel!.speciality != null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.userDoctor,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: 5),
                      Text("Speciality")
                    ],
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${profileModel!.speciality}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
