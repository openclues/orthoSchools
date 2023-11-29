import 'package:flutter/material.dart';
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
    return Container(
      decoration: BoxDecoration(
        // boxShadow: ,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          leading: Image.asset('assets/images/profilePhoto.png'),
          title: Text('dr.Ahnaf aljajaH DDS. Msc'),
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
