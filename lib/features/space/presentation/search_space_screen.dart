import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../Core/colors.dart';

class SearchSpaceScreen extends StatefulWidget {
  List<LatestUpdatedPost>? posts = [];
  SearchSpaceScreen({super.key, this.posts});

  @override
  State<SearchSpaceScreen> createState() => _SearchSpaceScreenState();
}

class _SearchSpaceScreenState extends State<SearchSpaceScreen> {
  TextEditingController searchController = TextEditingController();
  List<LatestUpdatedPost>? posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (v) {
            setState(() {
              posts = widget.posts!
                  .where((element) => element.content!
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
                  .toList();
            });
          },
          controller: searchController,
          decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: IconButton(
                  onPressed: () {
                    print(searchController.text.toString());
                    setState(() {
                      posts = widget.posts!
                          .where((element) => element.content!
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                    });
                  },
                  icon: const Icon(
                    IconlyLight.search,
                    color: primaryColor,
                  ))),
        ),
      ),
      body: posts!.isEmpty
          // ignore: prefer_const_constructors
          ? Center(
              child: const Text('No Posts Found'),
            )
          : ListView(
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Search Results",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: posts!.length,
                    itemBuilder: (context, index) {
                      posts = widget.posts!
                          .where((element) => element.content!
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                      return SpacePostWidget(post: widget.posts![index]);
                    }),
              ],
            ),
    );
  }
}
