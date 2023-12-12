import 'package:azsoon/screens/EditProfilePage.dart';
import 'package:azsoon/widgets/Button.dart';
import 'package:azsoon/widgets/IndicatorShape.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double coverHeight = screenHeight / 3.7;
    final double profilePictureHeight = 60;
    final double top = coverHeight - profilePictureHeight / 1.5;

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
                    'Sara Hossam Mohamed',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //bio
                  Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey)),

                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    buttonText: 'Edit Profile',
                    buttonColor: Color(0XFFF4F4F4),
                    borderColor: Color(0XFFF4F4F4),
                    textColor: Colors.black,
                    height: 43,
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfilePage()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
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
        backgroundImage: AssetImage('assets/images/profile.jpeg'),
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
          spaces(),
          //content of basic info
          activites(),
          //content of certificates
          courses(),
        ],
      ),
    );
  }

  Padding tab_bar_tabs() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TabBar(
        indicator: DotIndicator(),
        unselectedLabelColor: Color.fromARGB(255, 156, 156, 156),
        indicatorColor: Color(0XFF8174CC),
        controller: _tabController,
        labelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        tabs: [
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListView(
        children: [],
      ),
    );
  }

  Widget activites() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListView.builder(
        itemCount: spaceNames.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              //go to the ingo of the activity
            },
            title: Text(spaceNames[index]),
            subtitle: Text("You joined the space '${spaceNames[index]}'"),
            trailing: Image.asset(
              'assets/images/spacePhoto.png',
              width: 40,
            ), // Replace with your image
            // Add any other widgets or customizations as needed
          );
        },
      ),
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
}
