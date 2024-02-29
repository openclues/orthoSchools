import 'dart:convert';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/common_widgets/Post.dart';
import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import '../../../profile/data/my_profile_model.dart';
import '../../data/models/latest_updated_posts_model.dart';
import '../discover_screen.dart';
import '../widgets/post_widget.dart';

class SearchScreen extends StatefulWidget {
  final String? element;
  SearchScreen({Key? key, this.element}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  List<String> searchElements = [
    "Posts",
    "Articles",
    "Spaces",
    "Blogs",
    'People',
  ];

  bool isSearching = false;
  String? selectedElement;
  List<LatestUpdatedPost> posts = [];
  List<ArticlesModel> articles = [];
  List<BlogModel> blogs = [];
  List<RecommendedSpace> spaces = [];
  String? searchingWord;
  List<Profile> people = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    selectedElement = widget.element ?? "Posts";
    if (widget.element != null) {
      _searchResults(searchingWord);
    }
  }

  _searchResults(String? search) async {
    setState(() {
      isSearching = true;
      searchingWord = search;
    });

    try {
      if (selectedElement == "Posts") {
        var response = await RequestHelper.get('search/posts/?search=$search');
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          posts = (decodedData as List)
              .map((e) => LatestUpdatedPost.fromJson(e))
              .toList();
        }
      } else if (selectedElement == "Articles") {
        var response =
            await RequestHelper.get('search/articles/?search=$search');
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          articles = (decodedData as List)
              .map((e) => ArticlesModel.fromJson(e))
              .toList();
        }
      } else if (selectedElement == "Spaces") {
        var response = await RequestHelper.get('search/spaces/?search=$search');
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          spaces = (decodedData as List)
              .map((e) => RecommendedSpace.fromJson(e))
              .toList();
        }
      } else if (selectedElement == "Blogs") {
        var response = await RequestHelper.get('search/blogs/?search=$search');
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          blogs =
              (decodedData as List).map((e) => BlogModel.fromJson(e)).toList();
        }
      } else if (selectedElement == "People") {
        var response = await RequestHelper.get('manage/users/?search=$search');
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          people =
              (decodedData as List).map((e) => Profile.fromJson(e)).toList();
        }
      }
      // var response = await RequestHelper.get('search/posts/?search=$search');
      // if (response.statusCode == 200) {
      //   var decodedData = jsonDecode(response.body);
      //   if (selectedElement == 'Posts') {
      //     posts = (decodedData as List)
      //         .map((e) => LatestUpdatedPost.fromJson(e))
      //         .toList();
      //   } else if (selectedElement == 'Articles') {
      //     articles = (decodedData as List)
      //         .map((e) => ArticlesModel.fromJson(e))
      //         .toList();
      //   }
      // }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to maintain state
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (v) {
                if (v.isNotEmpty) {
                  _searchResults(v);
                } else {
                  setState(() {
                    posts.clear();
                    articles.clear();
                  });
                }
              },
              autofocus: true,
              decoration: InputDecoration(
                suffix: isSearching
                    ? Container(
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      )
                    : const SizedBox(),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: searchElements
                    .map((e) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedElement = e;
                            });
                            _searchResults(searchingWord);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontWeight: e == selectedElement
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: e == selectedElement
                                    ? primaryColor
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            if (blogs.isNotEmpty && selectedElement == 'Blogs')
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 200,
                      child: BlogDiscoveryItem(blog: blogs[index]));
                },
              ),
            if (posts.isEmpty &&
                (searchingWord == null || searchingWord!.isEmpty))
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Search for $selectedElement here',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            if (spaces.isNotEmpty && selectedElement == 'Spaces')
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: spaces.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 200,
                    child: RecommendedSpaceCard(
                      recommendedSpace: spaces[index],

                      // post: posts[index],
                    ),
                  );
                },
              ),

            // if (posts.isEmpty && searchingWord != null)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 20.0),
            //     child: Text(
            //       'No $selectedElement Found',
            //       textAlign: TextAlign.center,
            //       style: const TextStyle(fontSize: 20, color: Colors.grey),
            //     ),
            //   ),x
            if (selectedElement == "Spaces" && spaces.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'No Spaces Found',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            if (selectedElement == "People" && people.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: people.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.routeName,
                          arguments: {
                            "userId": people[index].user!.id,
                            "isNav": false,
                          });
                    },
                    leading: people[index].profileImage != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(people[index].profileImage!),
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                    title: Text(
                        "${people[index]!.user!.firstName} ${people[index].user!.lastName}"),
                    // subtitle: Text(people[index].email),
                  );
                },
              ),
            if (selectedElement == 'Posts' && posts.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return SpacePostWidget(
                    post: posts[index],
                  );
                },
              ),
            if (selectedElement == 'Articles' && articles.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticaleWidget(
                    articlesModel: articles[index],
                  );
                },
              ),
            if (selectedElement == 'Articles' && articles.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'No Articles Found',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
