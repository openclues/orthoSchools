import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/features/profile/bloc/activities_bloc.dart';
import 'package:azsoon/features/space/bloc/my_spaces_bloc.dart';
import 'package:azsoon/screens/NewProfile_page.dart';
import 'package:azsoon/widgets/Button.dart';
import 'package:azsoon/widgets/IndicatorShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../features/profile/bloc/profile_bloc.dart';

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
  final List<String> spaceNames = ['Space A', 'Space B', 'Space C'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    buildProfile(context);
    var profilestate = context.watch<ProfileBloc>().state;
    
    // buildListners(profilestate);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double coverHeight = screenHeight / 3.7;
    const double profilePictureHeight = 60;
    final double top = coverHeight - profilePictureHeight / 1.5;

    if (profilestate is ProfileLoaded) {
      print(profilestate.profileModel!.user!.firstName!);
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListView(children: [
            // buildCoverImage(coverHeight),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  child: buildCoverImage(coverHeight),
                ),
                Positioned(
                  top: top,
                  left: 10,
                  child: buildProfilePicture(profilePictureHeight),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.only(top: top / 1.5, right: 10, left: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${profilestate.profileModel!.user!.firstName!} ${profilestate.profileModel!.user!.lastName!}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    //bio

                    Text(profilestate.profileModel!.bio ?? "",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey)),
                    const SizedBox(
                      height: 15,
                    ),
                    //study in
                    const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.graduationCap,
                          size: 15,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Studied in Uskudar University",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //place of work
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
                            "Works at ${profilestate.profileModel!.placeOfWork}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey)),
                      ],
                    ),
                    if (profilestate.profileModel!.isme == true)
                      CustomButton(
                        buttonText: 'Edit Profile',
                        buttonColor: const Color(0XFFF4F4F4),
                        borderColor: const Color(0XFFF4F4F4),
                        textColor: Colors.black,
                        height: 43,
                        onpress: () async {
                          await Navigator.pushNamed(
                              context, NewProfile_Page.routeName);
                          if (context.mounted) {
                            context
                                .read<ProfileBloc>()
                                .add(const LoadMyProfile());
                          }
                        },
                      ),
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
                    const Divider(
                      thickness: 1,
                      color: Color(0XFFF4F4F4),
                    ),

                    tab_bar_tabs(),
                    //view of the tabs
                    tab_sections_view(),
                  ]),
            ),
          ]),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget buildCoverImage(double coverHight) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(15.0),
      //     bottomRight: Radius.circular(15.0),
      //   ),
      // ),
      child: Image.asset(
        'assets/images/postImage.png',
        width: double.infinity,
        height: coverHight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildProfilePicture(double profilePictureHeight) {
    return CircleAvatar(
      radius: profilePictureHeight, // adjust the radius as needed
      backgroundColor: const Color.fromARGB(255, 223, 223, 223), // border color
      child: CircleAvatar(
        radius: profilePictureHeight -
            4, // adjust the inner radius to leave room for the border
        backgroundImage: const AssetImage('assets/images/profile.jpeg'),
      ),
    );
  }

  Container tab_sections_view() {
    return Container(
      width: double.maxFinite,
      height: 300,
      child: TabBarView(
        controller: _tabController,
        children: [
          //content of spaces
          BlocProvider(
            create: (context) => MySpacesBloc(),
            child: spaces(),
          ),
          //content of basic info
          BlocProvider(
            create: (context) => ActivitiesBloc(),
            child: activites(),
          ),
          //content of certificates
          courses(),
        ],
      ),
    );
  }

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
        tabs: [
          const Tab(
            text: 'spaces',
          ),
          const Tab(
            text: 'activities',
          ),
          const Tab(
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
            child: Container(
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
        children: [],
      ),
    );
  }

  void buildProfile(BuildContext context) {
    if (context.read<ProfileBloc>().state is ProfileInitial) {
      context.read<ProfileBloc>().add(const LoadMyProfile());
    }
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



// maryim