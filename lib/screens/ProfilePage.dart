import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/features/profile/bloc/activities_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:azsoon/features/space/bloc/my_spaces_bloc.dart';
import 'package:azsoon/screens/NewProfile_page.dart';
import 'package:azsoon/common_widgets/Button.dart';
import 'package:azsoon/common_widgets/IndicatorShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../features/profile/bloc/profile_bloc.dart';
import '../features/profile/presentation/screens/create_blog_screen.dart';
import '../features/verification/persentation/screens/verification_pro_request_screen.dart';

//192.168.1.52

class ProfilePage extends StatefulWidget {
  final bool? isNav;
  final int? userId;

  const ProfilePage({super.key, this.isNav, this.userId});
  static const String routeName = '/profilepage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildProfile(context, id: widget.userId);
    var profilestate = context.watch<ProfileBloc>().state;

    // buildListners(profilestate);


    if (profilestate is ProfileLoaded) {
      if (profilestate.profileModel.user!.id == widget.userId ||
          widget.userId == null) {
        // _tabController = TabController(length: 3, vsync: this);}

        return PopScope(
          onPopInvoked: (didPop) {
            if (didPop) {
              if (widget.isNav == true) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreenPage.routeName, (route) => false);
              }
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: ListView(children: [
                ProfileImageAndCover(
                  speciality: profilestate.profileModel.speciality,
                  name:
                      "${profilestate.profileModel.user!.firstName!} ${profilestate.profileModel.user!.lastName!}",
                  profileImage: profilestate.profileModel.profileImage,
                  coverImage: profilestate.profileModel.cover,
                  isMe: profilestate.profileModel.isme,
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
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(profilestate.profileModel.bio ?? "",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey)),
                          ),

                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // if (profilestate.profileModel.bio == null)
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       TextButton.icon(
                        //           onPressed: () {},
                        //           icon: const Icon(Icons.add),
                        //           label: const Text("Add Bio")),
                        //     ],
                        //   ),

                        if (profilestate.profileModel.studyIn != null)
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.graduationCap,
                                size: 15,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("${profilestate.profileModel.studyIn}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey)),
                            ],
                          ),

                        //place of work
                        if (profilestate.profileModel.placeOfWork != null)
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.building,
                                size: 15,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "Works at ${profilestate.profileModel.placeOfWork}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey)),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),

                        // CustomButton(
                        //   buttonText: 'Edit Profile',
                        //   buttonColor: const Color(0XFFF4F4F4),
                        //   borderColor: const Color(0XFFF4F4F4),
                        //   textColor: Colors.black,
                        //   height: 43,
                        //   onpress: () async {
                        //     await Navigator.pushNamed(
                        //         context, NewProfile_Page.routeName);
                        //     if (context.mounted) {
                        //       context
                        //           .read<ProfileBloc>()
                        //           .add(const LoadMyProfile());
                        //     }
                        //   },
                        // ),
                        if (profilestate.profileModel.user!.isVerifiedPro ==
                                false &&
                            profilestate.profileModel.isme == true)
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                    child: const VerificationProRequestScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFFF4F4F4),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.userCheck,
                                    size: 15,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Verify your account and get a verified badge',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        //verified
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            if (profilestate.profileModel.user!.userRole == 2)
                              Image.asset(
                                'assets/images/verified-account.png',
                                width: 35,
                                height: 35,
                              ),
                            if (profilestate.profileModel.user!.isVerifiedPro ==
                                true)
                              Image.asset(
                                'assets/images/premium.png',
                                width: 35,
                                height: 35,
                              )
                          ],
                        ),

                        // const SizedBox(
                        //   height: 15,
                        // ),
                        BlogProfileWidget(profile: profilestate.profileModel),

                        //bio
                        // const SizedBox(
                        //   height: 15,
                        // ),

                        const SizedBox(
                          height: 15,
                        ),
                        //study in
                        const Divider(),

                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0XFFF4F4F4),
                        ),

                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // CustomButton(
                        //   buttonText: 'Edit Profile',
                        //   buttonColor: const Color(0XFFF4F4F4),
                        //   borderColor: const Color(0XFFF4F4F4),
                        //   textColor: Colors.black,
                        //   height: 43,
                        //   onpress: () {
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //       builder: (_) => BlocProvider.value(
                        //     //             value: context.read<ProfileBloc>(),
                        //     //             child: const EditProfilePage(),
                        //     //           )),
                        //     // );
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // const Divider(
                        //   thickness: 1,
                        //   color: Color(0XFFF4F4F4),
                        // ),
                        // if (profilestate.profileModel!.isme == true) tab_bar_tabs(),
                        // //view of the tabs
                        // if (profilestate.profileModel!.isme == true)
                        //   tab_sections_view(),
                      ]),
                ),
              ]),
            ),
          ),
        );
      } else {
        return const Center(
          child: Text("This is for another user"),
        );
      }
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  // Container tab_sections_view() {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     height: 300,
  //     child: TabBarView(
  //       controller: _tabController,
  //       children: [
  //         //content of spaces
  //         BlocProvider(
  //           create: (context) => MySpacesBloc(),
  //           child: spaces(),
  //         ),
  //         //content of basic info
  //         BlocProvider(
  //           create: (context) => ActivitiesBloc(),
  //           child: activites(),
  //         ),
  //         //content of certificates
  //         courses(),
  //       ],
  //     ),
  //   );
  // }

  Padding tab_bar_tabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TabBar(
        indicator: const DotIndicator(),
        unselectedLabelColor: const Color.fromARGB(255, 156, 156, 156),
        indicatorColor: const Color(0XFF8174CC),
        controller: _tabController,
        labelColor: Colors.black,
        labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        tabs: const [
          Tab(
            text: 'spaces',
          ),
          Tab(
            text: 'activities',
          ),
          Tab(
            text: 'courses',
          ),
        ],
      ),
    );
  }

  Widget spaces() {
    return BlocBuilder<MySpacesBloc, MySpacesState>(
      builder: (context, state) {
        if (state is MySpacesInitial) {
          context.read<MySpacesBloc>().add(LoadMySpaces(
                userId: widget.userId,
              ));
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MySpacesLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.spaces.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    child: RecommendedSpaceCard(
                        recommendedSpace: state.spaces[index]),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget activites() {
    return BlocBuilder<ActivitiesBloc, ActivitiesState>(
      builder: (context, state) {
        if (state is ActivitiesInitial) {
          context.read<ActivitiesBloc>().add(LoadActvites());
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActivitiesLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ListView.builder(
              itemCount: state.activities.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFFF4F4F4),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              IconlyBold.activity,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                "You ${state.activities[index].verb} ${state.activities[index].targetContentTypeName}  ${state.activities[index].actionObject}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is ActivitiesError) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget courses() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListView(
        children: const [],
      ),
    );
  }

  void buildProfile(BuildContext context, {int? id}) {
    if (id == null) {
      if (context.read<ProfileBloc>().state is ProfileInitial) {
        context.read<ProfileBloc>().add(const LoadMyProfile());
      }
    } else {
      // if (context.read<ProfileBloc>().state is ProfileInitial) {
      // context.read<ProfileBloc>().add(LoadProfileData(id: id));
      // }
    }
    // if (context.read<ProfileBloc>().state is ProfileInitial) {
    //   context.read<ProfileBloc>().add(LoadProfileData(id: id));
    // }
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

class VerificationStatus extends StatelessWidget {
  final Profile profile;
  const VerificationStatus({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      FontAwesomeIcons.userShield,
      size: 25,
      color: Colors.grey,
    );
  }
}

// maryim

class BlogProfileWidget extends StatelessWidget {
  final Profile profile;
  const BlogProfileWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.user!.isVerifiedPro == true &&
        profile.blog == null &&
        profile.isme == true) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            const Text(
              'You are a verified professional',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Create your blog and share your knowledge with the world',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              buttonText: 'Create Blog',
              buttonColor: const Color(0XFFF4F4F4),
              borderColor: const Color(0XFFF4F4F4),
              textColor: primaryColor,
              height: 43,
              onpress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ProfileBloc>(),
                      child: const BlogCreationScreen(),
                    ),
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (_) => BlocProvider.value(
                //             value: context.read<ProfileBloc>(),
                //             child: const EditProfilePage(),
                //           )),
                // );
              },
            ),
          ],
        ),
      );
    }
    return Container();
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("data".toString());
    // return buildCoverImage();
  }
}

Widget buildCoverImage(String? profileImage) {
  return SizedBox(
      height: 400,
      width: double.infinity,
      child: profileImage != null
          ? Image.network(
              profileImage,
              fit: BoxFit.fill,
            )
          : Image.network(
              'https://trusteid.mioa.gov.mk/wp-content/plugins/uix-page-builder/uixpb_templates/images/UixPageBuilderTmpl/default-cover-2.jpg',
              fit: BoxFit.fill,
            ));
}

class ProfileImageAndCover extends StatelessWidget {
  final String? profileImage;
  final String? coverImage;
  final String? speciality;
  final bool? isMe;
  final String? name;

  const ProfileImageAndCover(
      {Key? key,
      this.speciality,
      this.profileImage,
      this.coverImage,
      this.isMe,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 80, // Adjust the overall height of the container
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            child: buildCoverImage(coverImage),
          ),
          if (isMe == true)
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () async {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
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
          Positioned(
            bottom: -50,
            left: 10, // Adjust the bottom position of the profile picture
            child: buildProfilePicture(profileImage, isMe, name!),
          ),

          // Positioned(bottom: ,)
          Positioned(
            bottom: -60, // Adjust the bottom position of the profile picture
            // left: 24,
            child: Padding(
              padding: const EdgeInsets.only(left: 90, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // ),
                    margin: const EdgeInsets.symmetric(
                        // horizontal: 19,
                        ),
                    child: Text(
                      name!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SpecialityWidget(speciality: speciality)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SpecialityWidget extends StatelessWidget {
  const SpecialityWidget({
    super.key,
    required this.speciality,
  });

  final String? speciality;

  @override
  Widget build(BuildContext context) {
    return Text(
      speciality != null ? "$speciality" : "",
      style: const TextStyle(
        fontSize: 15,
        color: primaryColor,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

Widget buildProfilePicture(String? profileImage, bool? isMe, String name) {
  return Stack(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(
                color: primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 223, 223, 223),
            ),
            child: profileImage == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      image: AssetImage('assets/images/drimage.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ],
      ),
      // CircleAvatar(
      //   radius: 50, // Adjust the radius of the profile picture
      //   backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      //   child: CircleAvatar(
      //     radius: 75, // Adjust the inner circle radius
      //     backgroundImage: profileImage == null
      //         ? const AssetImage('assets/images/drimage.png')
      //         : NetworkImage(profileImage) as ImageProvider,
      //   ),
      // ),
      // if (isMe == true)
      Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () async {
            // ... (unchanged)
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                IconlyBold.camera,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
