import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/Providers/userInfoProvider.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:azsoon/widgets/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/userinfoClass.dart';
// import '../Providers/DrawerNavProvider.dart';

class NavigationDrawer extends StatelessWidget {
  // const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              Divider(
                thickness: 1,
              ),
              buildMenuItems(context),
            ]),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: ListTile(
        title: Text('sara hossam '),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          // backgroundImage:  Image.asset(''),
        ),

        // subtitle: Text(userProvider.user.email),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 1,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              child: ListTile(
                // trailing: Icon(
                //   Icons.verified,
                //   color: Colors.blue,
                // ),
                leading: Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
                title: Text(
                  'Become Verified Now!',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 1,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.yellow[800],
                  size: 25,
                ),
                title: Text(
                  'Want To Be Verified Pro?',
                ),
              ),
            ),
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

          SizedBox(
            height: 30,
          ),
          Divider(),
          // BottomNavItems(
          //   itemtitle: 'Profile',
          //   itemIcon: Icons.person,
          //   ontap: () {
          //     //navigate to profile page
          //     Navigator.of(context).pushNamed(ProfilePage.routeName);
          //   },
          // ),
          BottomNavItems(
            itemtitle: 'About',
            itemIcon: Icons.insert_drive_file_rounded,
          ),
          BottomNavItems(
            itemtitle: 'Saved Posts',
            itemIcon: Icons.save_alt_outlined,
          ),
          BottomNavItems(
            itemtitle: 'Favorite posts',
            itemIcon: Icons.favorite_border,
          ),
          // BottomNavItems(
          //   itemtitle: 'Settings',
          //   itemIcon: Icons.settings,
          //   ontap: () {
          //     //navigate to settings page
          //     Navigator.of(context).pushNamed(SettingsScreen.routeName);
          //   },
          // ),
          BottomNavItems(
            itemtitle: 'Help Center',
            itemIcon: Icons.privacy_tip_outlined,
          ),
          BottomNavItems(
            itemtitle: 'Notifications',
            itemIcon: Icons.notifications_none,
          ),
          BottomNavItems(
            itemtitle: 'Sign out',
            itemIcon: Icons.login,
            ontap: () async {
              //sign out
              await LocalStorage.removeAuthToken().then((_) {
                if (context.mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(LoadingScreen.routeName);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class SpacesCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? urlImage;

  SpacesCard({this.title, this.subtitle, this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0XFFE9E9E9), // Background color for the ListTile
        borderRadius:
            BorderRadius.circular(12), // Adjust the radius for rounded corners
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        leading: Image.asset(
          urlImage!,
          width: 43,
        ),
        title: Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle!),
      ),
    );
  }
}

class NavigationTextBar extends StatelessWidget {
  final String? text;
  final Function()? onTap;

  const NavigationTextBar({
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(
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

  BottomNavItems({this.itemtitle, this.itemIcon, this.ontap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(itemIcon), // Prefix Icon
            SizedBox(width: 8), // Add some space between the icon and text
            Text(itemtitle!), // Text
          ],
        ),
      ),
    );
  }
}
