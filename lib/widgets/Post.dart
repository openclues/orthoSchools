import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/Providers/userInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Navigation-Drawer.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  DateTime time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    MoreInfoUserProvider moreInfoUserProvider =
        Provider.of<MoreInfoUserProvider>(context);
    return Container(
      decoration: BoxDecoration(
        // boxShadow: ,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
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
          title: Text(
              "${moreInfoUserProvider.user.speciality}  ${userProvider.user.firstName}"),
          subtitle: Text(
            "${time} PM",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 10), // Add space between widgets
        Text(
          'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
          style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10), // Add space between widgets
        Image.asset('assets/images/postImage.png'),
        Row(
          children: [
            BottomNavItems(
              itemtitle: 'Like',
              itemIcon: Icons.favorite,
            ),
            BottomNavItems(
              itemtitle: 'Comment',
              itemIcon: Icons.comment,
            ),
            BottomNavItems(
              itemtitle: 'Share',
              itemIcon: Icons.share,
            ),
          ],
        )
      ]),
    );
  }
}
