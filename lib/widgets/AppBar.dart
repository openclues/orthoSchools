import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: ListTile(
        leading: Image.asset('assets/images/profilePhoto.png'),
        title: Text('Yassine Bassou'),
        subtitle: Text('Yassin@gamil.com'),
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
            decoration: InputDecoration(
                hintText: 'What are you searching for?',
                suffixIcon: Icon(Icons.search)),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 0),
            title: Text('Home'),
            subtitle: Divider(
              thickness: 1,
            ),
          ),
          ExpansionTile(
            initiallyExpanded: false,
            title: Text('COURSES'),
            // subtitle: Divider(
            //   thickness: 1,
            // ),
            trailing: Icon(Icons.add), // Your trailing icon
            children: [
              Text('COURSES OFFERED'),
              Divider(
                thickness: 1,
              ),
              Text('MY COURSES'),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            title: Text('FOLLOWING'),
            subtitle: Divider(
              thickness: 1,
            ),
          ),

          Text('Spaces'),
          Container(
            decoration: BoxDecoration(
              color: Color(0XFFE9E9E9), // Background color for the ListTile
              borderRadius: BorderRadius.circular(
                  12), // Adjust the radius for rounded corners
            ),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              leading: Image.asset(
                'assets/images/spacePhoto.png',
                width: 35,
              ),
              title: Text('FOLLOWING'),
              subtitle: Text('50 member'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color(0XFFE9E9E9), // Background color for the ListTile
              borderRadius: BorderRadius.circular(
                  12), // Adjust the radius for rounded corners
            ),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              leading: Image.asset(
                'assets/images/spacePhoto.png',
                width: 35,
              ),
              title: Text('FOLLOWING'),
              subtitle: Text('50 member'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0XFFE9E9E9), // Background color for the ListTile
              borderRadius: BorderRadius.circular(
                  12), // Adjust the radius for rounded corners
            ),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              leading: Image.asset(
                'assets/images/spacePhoto.png',
                width: 35,
              ),
              title: Text('FOLLOWING'),
              subtitle: Text('50 member'),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          BottomNavItems(
            itemtitle: 'Profile',
            itemIcon: Icons.person,
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
