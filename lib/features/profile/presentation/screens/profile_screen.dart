import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/profile/data/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../bloc/profile_bloc.dart';
import '../../data/my_profile_model.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  final bool? isNav;
  const ProfileScreen({super.key, this.isNav});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    context.read<ProfileBloc>().add(const LoadProfileData(id: 3));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // ignore: prefer_const_constructors
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
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
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
                    const Text(
                      "Islam Ahmed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(width: 10),
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
                        child: Image.asset('assets/images/premium.png',
                            height: 25)),
                    const SizedBox(width: 5),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  ' Flutter Developer',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              //bio
              const SizedBox(height: 10),
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
        },
      ),
    );
  }
}
