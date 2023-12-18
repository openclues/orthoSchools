import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/blog/presentation/screens/eachBlog.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  static const String routeName = '/blogScreen';
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

late TabController _tabController;

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        bottom: tab_bar_tabs(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: tab_sections_view(),
      ),
    );
  }

  Container top_articles() {
    final List<Map<String, dynamic>> topAtricles = [
      {
        'bgImage': 'assets/images/close-up-businessman-with-digital-tablet.jpg',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'bgImage': 'assets/images/close-up-businessman-with-digital-tablet.jpg',
        'title': 'Item 2',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'bgImage': 'assets/images/close-up-businessman-with-digital-tablet.jpg',
        'title': 'Item 1',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'bgImage': 'assets/images/close-up-businessman-with-digital-tablet.jpg',
        'title': 'Item 2',
        'subtitle': 'Subtitle for Item 2',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
    ];
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 240,
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: topAtricles.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 350,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(topAtricles[index]['bgImage']),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            //  child: Stack(),
          );
        },
      ),
    );
  }

  Container other_articles() {
    final List<Map<String, dynamic>> atricles = [
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/postImage.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'subtitle': 'Subtitle for Item 2',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
      {
        'image': 'assets/images/spacePhoto.png',
        'title':
            'dr belaynish not answering our texts, and she did not upload our grades yet!!',
        'blogText':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'subtitle': 'Subtitle for Item 2',
        'authorName': 'sara kaya',
        'authorImage': 'assets/images/profile.jpeg',
        'hour': '12 hours ago',
        'hourIcon': Icons.timelapse_rounded,
      },
    ];
    return Container(
      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: atricles.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              tileColor: Color.fromARGB(255, 252, 229, 255),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              dense: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      image: atricles[index]['image'],
                      authorImage: atricles[index]['authorImage'],
                      authorName: atricles[index]['authorName'],
                      topicTitle: atricles[index]['title'],
                      topicText: atricles[index]['blogText'],
                      publishTime: atricles[index]['hour'],
                    ),
                  ),
                );
              },
              leading: Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    atricles[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Image.asset(
              //     atricles[index]['image'],
              //     fit: BoxFit.cover,
              //   ),
              title: Text(
                atricles[index]['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          atricles[index]['authorImage'],
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          atricles[index]['authorName'],
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          atricles[index]['hourIcon'],
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          atricles[index]['hour'],
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container tab_sections_view() {
    return Container(
      child: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              top_articles(),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Other articles',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(child: other_articles()),
            ],
          ),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      ),
    );
  }

  PreferredSizeWidget tab_bar_tabs() {
    return TabBar(
      unselectedLabelColor: Color.fromARGB(255, 156, 156, 156),
      padding: EdgeInsets.only(left: 20, right: 20),
      indicatorColor: Color(0XFF8174CC),
      // indicator: DotIndicator(),

      controller: _tabController,
      labelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      tabs: [
        Tab(
          text: 'Home',
        ),
        Tab(
          text: 'For you',
        ),
        Tab(
          text: 'Bookmark',
        ),
        Tab(
          text: 'Technical',
        ),
      ],
    );
  }
}
