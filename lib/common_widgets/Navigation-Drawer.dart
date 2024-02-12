
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/blog/bloc/cubit/blog_cupit_cubit.dart';
import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/premiem_zone/presentation/prem_screen.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/verification/persentation/screens/verification_pro_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../features/become_premium/presentation/be_premium_screen.dart';
// import '../Providers/DrawerNavProvider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  // const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        // margin: const EdgeInsets.only(top: 50),
        // height: MediaQuery.of(context).size.height *
        //     0.4, // Adjust the height as needed
        width: MediaQuery.of(context).size.width *
            0.8, // Adjust the width as needed
        decoration: BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Your header widget
            // buildHeader(context),
            // const Divider(
            //   thickness: 1,
            // ),
            // Your menu items widget
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    var user = context.watch<LoadingBlocBloc>().state as UserIsSignedIn;
    return Container(
      height: 50,
    );
  }

  Widget buildMenuItems(BuildContext context) {
    // context.read<ProfileBloc>().add(const LoadMyProfile());

    var user = context.watch<ProfileBloc>().state;
    print((user as ProfileLoaded).profileModel.blog);
    return Container(
      margin: const EdgeInsets.only(top: 70, left: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 0.2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.only(
                    top: .0, left: 16.0, bottom: 16.0, right: 16.0),
                child: Text(
                  'More ..',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            if (user.profileModel.blog != null)
              GestureDetector(
                onTap: () {
                  print(user.profileModel.blog!.cover.toString());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => BlogCupitCubit(),
                            child: BlogScreen(
                              blog: BlogsModel(
                                cover: user.profileModel.blog!.cover,
                                user: user.profileModel.blog!.user,
                                description:
                                    user.profileModel.blog!.description,
                                id: user.profileModel.blog!.id,
                                title: user.profileModel.blog!.title,
                              ),
                            ),
                          )));
                },
                child: DrawerItem(
                  title: 'My Blog',
                  leading: Container(
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
                    child: const Icon(
                      FontAwesomeIcons.blog,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            if (user.profileModel.user!.userRole == 1)
              //send request to be premium
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushNamed(PartnerForm.routeName);
                  // var response =
                  //     RequestHelper.post('send/premium/', {}).then((value) {
                  //   // SnackBarWidget.success(
                  //   //     jsonDecode(value.body)['message'].toString());
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       content: Text(
                  //           jsonDecode(value.body)['message'].toString())));
                  // });
                  // Navigator.pop(context);
                },
                child: DrawerItem(
                  title: 'Become a premium',
                  leading: Container(
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
                    child: const Icon(
                      FontAwesomeIcons.userShield,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),

            if (user.profileModel.user!.userRole == 2)
              //about
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(VerificationProRequestScreen.routeName);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                          value: context.read<ProfileBloc>(),
                          child: const PremiumZone())));
                },
                child: DrawerItem(
                  title: 'Premium Zone',
                  leading: Container(
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
                    child: const Icon(
                      FontAwesomeIcons.buildingCircleCheck,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            user.profileModel.user!.isVerifiedPro! == true
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(VerificationProRequestScreen.routeName);
                    },
                    child: DrawerItem(
                      title: 'Become a verified pro',
                      leading: Container(
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
                    ),
                  ),

            // //about
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context).pushNamed(VerificationProRequestScreen.routeName);
            //   },
            //   child: DrawerItem(
            //     title: 'About us',
            //     leading: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white,
            //         boxShadow: const [
            //           BoxShadow(
            //               color: Colors.grey,
            //               offset: Offset(0, 0.5),
            //               blurRadius: 1)
            //         ],
            //       ),
            //       child: const Icon(
            //         FontAwesomeIcons.buildingCircleCheck,
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // //saved posts and favorite posts
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context).pushNamed(VerificationProRequestScreen.routeName);
            //   },
            //   child: DrawerItem(
            //     title: 'Saved Posts',
            //     leading: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white,
            //         boxShadow: const [
            //           BoxShadow(
            //               color: Colors.grey,
            //               offset: Offset(0, 0.5),
            //               blurRadius: 1)
            //         ],
            //       ),
            //       child: const Icon(
            //         FontAwesomeIcons.bookmark,
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),

            // const SizedBox(
            //   height: 5,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context).pushNamed(VerificationProRequestScreen.routeName);
            //   },
            //   child: DrawerItem(
            //     title: 'Favorite Posts',
            //     leading: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white,
            //         boxShadow: const [
            //           BoxShadow(
            //               color: Colors.grey,
            //               offset: Offset(0, 0.5),
            //               blurRadius: 1)
            //         ],
            //       ),
            //       child: const Icon(
            //         FontAwesomeIcons.heart,
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),

            // const SizedBox(
            //   height: 5,
            // ),

            // //help center   and notifications
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context).pushNamed(VerificationProRequestScreen.routeName);
            //   },
            //   child: DrawerItem(
            //     title: 'Help Center',
            //     leading: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white,
            //         boxShadow: const [
            //           BoxShadow(
            //               color: Colors.grey,
            //               offset: Offset(0, 0.5),
            //               blurRadius: 1)
            //         ],
            //       ),
            //       child: const Icon(
            //         FontAwesomeIcons.questionCircle,
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 255, 255, 255),
            //     borderRadius: BorderRadius.circular(10),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.2),
            //         offset: const Offset(0, 2),
            //         blurRadius: 1,
            //         spreadRadius: 0.2,
            //       ),
            //     ],
            //   ),
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.workspace_premium_rounded,
            //       color: Colors.yellow[800],
            //       size: 25,
            //     ),
            //     title: const Text(
            //       'Want To Be Verified Pro?',
            //     ),
            //   ),
            // ),
            // ExpansionTile(
            //   tilePadding: EdgeInsets.all(0),
            //   initiallyExpanded: false,
            //   title: Text(
            //     'COURSES',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),

            //   trailing: Icon(Icons.add), // Your trailing icon
            //   children: [
            //     NavigationTextBar(
            //       text: 'Courses offered',
            //       onTap: () {
            //         // Your onTap function
            //       },
            //     ),
            //     NavigationTextBar(
            //       text: 'My courses',
            //       onTap: () {
            //         // Your onTap function
            //       },
            //     ),
            //   ],
            // ),
          ]),

          // Text('Spaces', style: TextStyle(fontWeight: FontWeight.bold)),
          // SizedBox(
          //   height: 5,
          // ),
          // SpacesCard(
          //   title: 'Medical Space',
          //   subtitle: '50 member',
          //   urlImage: 'assets/images/spacePhoto.png',
          // ),
          // SpacesCard(
          //   title: 'Computer Sapce',
          //   subtitle: '55 member',
          //   urlImage: 'assets/images/spacePhoto.png',
          // ),

          // SpacesCard(
          //   title: 'Art Space',
          //   subtitle: '22 member',
          //   urlImage: 'assets/images/spacePhoto.png',
          // ),

          // Divider(
          //   thickness: 1,
          // ),

          // const SizedBox(
          //   height: 30,
          // ),
          const Divider(),
          // BottomNavItems(
          //   itemtitle: 'Profile',
          //   itemIcon: Icons.person,
          //   ontap: () {
          //     //navigate to profile page
          //     Navigator.of(context).pushNamed(ProfilePage.routeName);
          //   },
          // // ),
          // BottomNavItems(
          //   itemtitle: 'About',
          //   itemIcon: Icons.insert_drive_file_rounded,
          // ),
          // BottomNavItems(
          //   itemtitle: 'Saved Posts',
          //   itemIcon: Icons.save_alt_outlined,
          // ),
          // BottomNavItems(
          //   itemtitle: 'Favorite posts',
          //   itemIcon: Icons.favorite_border,
          // ),
          // // BottomNavItems(
          // //   itemtitle: 'Settings',
          // //   itemIcon: Icons.settings,
          // //   ontap: () {
          // //     //navigate to settings page
          // //     Navigator.of(context).pushNamed(SettingsScreen.routeName);
          // //   },
          // // ),
          // BottomNavItems(
          //   itemtitle: 'Help Center',
          //   itemIcon: Icons.privacy_tip_outlined,
          // ),
          // BottomNavItems(
          //   itemtitle: 'Notifications',
          //   itemIcon: Icons.notifications_none,
          // ),
          // BottomNavItems(
          //   itemtitle: 'Sign out',
          //   itemIcon: Icons.login,
          //   ontap: () async {
          //     //sign out
          //     await LocalStorage.removeAll().then((_) {
          //       if (context.mounted) {
          //         Navigator.of(context)
          //             .pushReplacementNamed(LoadingScreen.routeName);
          //       }
          //     });
          //   },
          // ),
          //lOGOUT

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  //sign out
                  await LocalStorage.removeAll().then((_) {
                    if (context.mounted) {
                      Navigator.of(context)
                          .pushReplacementNamed(LoadingScreen.routeName);
                    }
                  });
                },
                child:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.logout,
          //     color: Colors.red,
          //   ),
          //   title: const Text(
          //     'Logout',
          //     style: TextStyle(color: Colors.red),
          //   ),
          //   onTap: () async {
          //     //sign out
          //     await LocalStorage.removeAll().then((_) {
          //       if (context.mounted) {
          //         Navigator.of(context)
          //             .pushReplacementNamed(LoadingScreen.routeName);
          //       }
          //     });
          //   },
          // )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final Widget leading;
  const DrawerItem({
    required this.title,
    required this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          // borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 0.2,
            ),
          ],
        ),
        child: ListTile(
            title: Text(
              title,
            ),
            // trailing: Icon(
            //   Icons.verified,
            //   color: Colors.blue,
            // ),
            leading: leading));
  }
}

class SpacesCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? urlImage;

  const SpacesCard({super.key, this.title, this.subtitle, this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0XFFE9E9E9), // Background color for the ListTile
        borderRadius:
            BorderRadius.circular(12), // Adjust the radius for rounded corners
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        leading: Image.asset(
          urlImage!,
          width: 43,
        ),
        title: Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle!),
      ),
    );
  }
}

class NavigationTextBar extends StatelessWidget {
  final String? text;
  final Function()? onTap;

  const NavigationTextBar({super.key, 
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: onTap,
            child: Text(
              text!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}

class BottomNavItems extends StatelessWidget {
  final String? itemtitle;
  final IconData? itemIcon;
  final Function()? ontap;

  const BottomNavItems({super.key, this.itemtitle, this.itemIcon, this.ontap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(itemIcon), // Prefix Icon
            const SizedBox(
                width: 8), // Add some space between the icon and text
            Text(itemtitle!), // Text
          ],
        ),
      ),
    );
  }
}
