import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/Providers/userInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/userinfoClass.dart';
import '../Providers/DrawerNavProvider.dart';

class NavigationDrawer extends StatelessWidget {
  // const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    DrawerProvider drawerProvider = Provider.of<DrawerProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    MoreInfoUserProvider moreInfoUserProvider =
        Provider.of<MoreInfoUserProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: moreInfoUserProvider.user.profileImage != null
              ? NetworkImage(moreInfoUserProvider.user.profileImage)
              : null,
          child: moreInfoUserProvider.user.profileImage == null
              ? Center(
                  child: Image.asset('assets/images/drimage.png'),
                )
              : null, // Remove Center widget if profileImage is not null
        ),
        // title: Text(userProvider.user.firstName),
        // subtitle: Text(userProvider.user.email),
        trailing: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.close,
            size: 16,
          ),
          backgroundColor: Color(0XFF2F7EDB),
          mini: true,
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          //searchBar
          TextField(
            // controller: controller,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: 'search...',
              hintStyle: TextStyle(color: Color(0XFF939199)),
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Color(0XFF2F7EDB),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFF2F7EDB),
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(children: [
            NavigationTextBar(
              text: 'HOME',
              onTap: () {
                // Your onTap function
              },
            ),
            SizedBox(
              height: 15,
            ),
            NavigationTextBar(
              text: 'SPACES',
              onTap: () {
                // Your onTap function
              },
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.all(0),
              initiallyExpanded: false,
              title: Text(
                'COURSES',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              trailing: Icon(Icons.add), // Your trailing icon
              children: [
                NavigationTextBar(
                  text: 'Courses offered',
                  onTap: () {
                    // Your onTap function
                  },
                ),
                NavigationTextBar(
                  text: 'My courses',
                  onTap: () {
                    // Your onTap function
                  },
                ),
              ],
            ),
            NavigationTextBar(
              text: 'My Blog',
              onTap: () {
                // Your onTap function
              },
            ),
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
          BottomNavItems(
            itemtitle: 'Profile',
            itemIcon: Icons.person,
            ontap: () {
              Navigator.of(context).pushNamed('createProfile');
            },
          ),
          BottomNavItems(
            itemtitle: 'About',
            itemIcon: Icons.insert_drive_file_rounded,
          ),
          BottomNavItems(
            itemtitle: 'Saved Posts',
            itemIcon: Icons.save_alt_outlined,
          ),
          BottomNavItems(
            itemtitle: 'Settings',
            itemIcon: Icons.settings,
          ),
          BottomNavItems(
            itemtitle: 'Sign out',
            itemIcon: Icons.login,
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
