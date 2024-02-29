import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Core/colors.dart';
import '../../../../screens/NewProfile_page.dart';
import '../../../../screens/ProfilePage.dart';
import '../../bloc/another_user_bloc.dart';

class AnotherUserScreen extends StatefulWidget {
  final int userId;
  const AnotherUserScreen({super.key, required this.userId});

  @override
  State<AnotherUserScreen> createState() => _AnotherUserScreenState();
}

class _AnotherUserScreenState extends State<AnotherUserScreen> {
  @override
  Widget build(BuildContext context) {
    var profile = context.watch<AnotherUserBloc>().state;
    return Scaffold(
      //update the top bar color
      appBar: AppBar(
        backgroundColor: bodyColor,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: primaryColor),
        ),
      ),

      backgroundColor: profile is AnotherUserLoaded &&
              profile.profileModel!.user!.userRole == 2
          ? Colors.amberAccent
          : null,
      body: BlocBuilder<AnotherUserBloc, AnotherUserState>(
        builder: (context, profilestate) {
          if (profilestate is AnotherUserInitial) {
            context
                .read<AnotherUserBloc>()
                .add(AnotherUserLoad(userId: widget.userId));
          } else if (profilestate is AnotherUserLoaded) {
            return ListView(children: [
              Container(
                color: primaryColor,
                child: ProfileImageAndCover(
                  profile: profilestate.profileModel,
                  // isVerifiedPro: profilestate.profileModel!.user!.isVerifiedPro,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 55),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      if (profilestate.profileModel.blog != null)
                        Text(
                          '@${profilestate.profileModel.blog!.title}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: primaryColor),
                        ),
                      if (profilestate.profileModel.bio != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(profilestate.profileModel.bio ?? "",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey[500])),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (profilestate.profileModel.studyIn != null &&
                                    profilestate.profileModel.studyIn != "")
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.graduationCap,
                                          size: 15,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "${profilestate.profileModel.studyIn}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: primaryColor)),
                                      ],
                                    ),
                                  ),

                                //place of work
                                if (profilestate.profileModel.placeOfWork !=
                                        null &&
                                    profilestate.profileModel.placeOfWork != "")
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.building,
                                          size: 15,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                              "${profilestate.profileModel.placeOfWork}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      BlogProfileWidget(profile: profilestate.profileModel),
                    ]),
              ),
            ]);
          }
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        },
      ),
    );
  }
}
