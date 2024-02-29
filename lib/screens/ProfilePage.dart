import 'dart:io';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/post_widget.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/features/profile/bloc/activities_bloc.dart';
import 'package:azsoon/features/profile/bloc/another_user_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:azsoon/features/space/bloc/my_spaces_bloc.dart';
import 'package:azsoon/screens/NewProfile_page.dart';
import 'package:azsoon/common_widgets/Button.dart';
import 'package:azsoon/common_widgets/IndicatorShape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../features/profile/bloc/profile_bloc.dart';
import '../features/profile/presentation/screens/another_user_screen.dart';
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

        return MyProfileScreen(widget: widget, profilestate: profilestate);
      } else {
        return AnotherUserScreen(
          userId: widget.userId!,
        );
      }
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

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

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    super.key,
    required this.widget,
    required this.profilestate,
  });

  final ProfilePage widget;
  final ProfileState profilestate;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool? addingBio = false;
  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var profilestate = context.watch<ProfileBloc>().state;
    if (profilestate is ProfileLoaded) {
      return PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            if (widget.widget.isNav == true) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreenPage.routeName, (route) => false);
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: profilestate.profileModel.user!.userRole == 2
              ? Colors.amberAccent
              : Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: ListView(children: [
              Container(
                color: primaryColor,
                child: ProfileImageAndCover(
                  profile: profilestate.profileModel,
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
                      if (profilestate.profileModel.bio != null &&
                          profilestate.profileModel.bio != "")
                        InkWell(
                          onTap: () {
                            setState(() {
                              addingBio = true;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
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
                          ),
                        ),
                      if (addingBio == true)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: bioController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText:
                                        profilestate.profileModel.bio == null ||
                                                profilestate
                                                    .profileModel.bio!.isEmpty
                                            ? "Add bio"
                                            : profilestate.profileModel.bio,
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: primaryColor,
                                    ),
                                    onPressed: () async {
                                      if (bioController.text.isNotEmpty) {
                                        var response = await RequestHelper.post(
                                            'update/bio/', {
                                          "bio": bioController.text,
                                        });
                                        if (response.statusCode == 200) {
                                          context
                                              .read<ProfileBloc>()
                                              .add(LoadMyProfile());
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Error adding bio"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }

                                        setState(() {
                                          addingBio = false;
                                        });
                                        print(response.body);
                                      }
                                      // var response = await RequestHelper.post(
                                      //     'update/profile/', {
                                      //   "bio": "bio",
                                      // });

                                      setState(() {
                                        addingBio = false;
                                      });
                                    },
                                    child: Text(
                                        profilestate.profileModel.bio != null &&
                                                profilestate.profileModel.bio!
                                                    .isNotEmpty
                                            ? "Update"
                                            : "Save",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        addingBio = false;
                                      });
                                    },
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if ((profilestate.profileModel.bio == null ||
                              profilestate.profileModel.bio == "") &&
                          addingBio == false)
                        InkWell(
                          onTap: () {
                            setState(() {
                              addingBio = true;
                            });
                            // Navigator.pushNamed(
                            //     context, NewProfile_Page.routeName);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                    text: TextSpan(
                                  text:
                                      "Add bio to your profile to let people know you better",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[500]),
                                )),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (profilestate.profileModel.blog != null)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, BlogScreen.routeName,
                                          arguments:
                                              profilestate.profileModel.blog);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.blog,
                                            size: 15,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            ' ${profilestate.profileModel.blog!.title}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, NewProfile_Page.routeName);
                              },
                              child: const Text(
                                "Edit profile",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    ]),
              ),
            ]),
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
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
          : Image.asset('assets/images/default_cover.jpeg', fit: BoxFit.cover));
}

class ProfileImageAndCover extends StatelessWidget {
  final Profile? profile;
  // final String? profileImage;
  // final String? coverImage;
  // final String? speciality;
  // final bool? isMe;
  // final String? name;

  const ProfileImageAndCover({
    Key? key,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      // height: 80, // Adjust the overall height of the container
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            child: buildCoverImage(profile!.cover),
          ),
          if (profile!.isme == true)
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () async {
                  //pick image
                  XFile? cover = await CommonMethods.pickImage();
                  if (cover != null) {
                    //show preview and dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Preview"),
                          content: Image.file(File(cover.path)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                var response = await RequestHelper.post(
                                    'upload/cover/image',
                                    {
                                      "cover": cover.path,
                                    },
                                    files: [cover],
                                    filesKey: 'coverImage');
                                if (response.statusCode == 200) {
                                  Navigator.pop(context);

                                  context.read<ProfileBloc>().add(
                                      const LoadMyProfile(
                                          withputLoading: true));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Error adding cover"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: const Text("Save"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
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
            bottom: -57,
            left: 20, // Adjust the bottom position of the profile picture
            child: Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width according to your requirement
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildProfilePicture(profile!.profileImage, profile!.isme,
                      "${profile!.user!.firstName!} ${profile!.user!.lastName!}",
                      context: context),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.symmetric(),
                                child: Text(
                                  "${profile!.user!.firstName!} ${profile!.user!.lastName!}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            BagesRow(
                                isVeriedPro: profile!.user!.isVerifiedPro,
                                isPremium: profile!.user!.userRole == 2),
                            const SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                        SpecialityWidget(speciality: profile!.speciality),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // if (profilestate.profileModel.user!.userRole == 2)
                ],
              ),
            ),
          ),

          // Positioned(bottom: ,)
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

Widget buildProfilePicture(String? profileImage, bool? isMe, String name,
    {BuildContext? context}) {
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
      if (isMe == true)
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () async {
              // ... (unchanged)
              XFile? image = await CommonMethods.pickImage();
              if (image != null) {
                //show preview and dialog
                showDialog(
                  context: context!,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Preview"),
                      content: Image.file(File(image.path)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            var response = await RequestHelper.post(
                                'upload/profile/image',
                                {
                                  "profile": image.path,
                                },
                                files: [image],
                                filesKey: 'profileImage');
                            if (response.statusCode == 200) {
                              Navigator.pop(context);

                              context.read<ProfileBloc>().add(
                                  const LoadMyProfile(withputLoading: true));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error adding profile image"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    );
                  },
                );
              }
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
