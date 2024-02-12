import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:flutter/material.dart';

import '../../../blog/data/models/blog_model.dart';

class ReadingZone extends StatefulWidget {
  final int? categoryId;

  const ReadingZone({super.key, required this.categoryId});

  @override
  State<ReadingZone> createState() => _ReadingZoneState();
}

class _ReadingZoneState extends State<ReadingZone> {
  late Future<List<PostModel>> _articlesFuture;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _articlesFuture = getArticles();
    _pageController = PageController();
  }

  Future<List<PostModel>> getArticles() async {
    var response = await RequestHelper.get(
        "read/articles/?category_id=${widget.categoryId}");

    if (response.statusCode == 200) {
      List<PostModel> articles = [];

      for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
        articles.add(PostModel.fromJson(item));
      }
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Zone'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _articlesFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Loading your reading zone'),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            List<PostModel> articles = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          children: [
                            Text(
                              articles[index].title!,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            // Text(articles[index].plainText!),
                          ],
                        ),
                      );
                    },
                    itemCount: articles.length,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (_pageController.page! > 0) {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (_pageController.page! < articles.length - 1) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Text('Unexpected Error');
        },
      ),
    );
  }
}
