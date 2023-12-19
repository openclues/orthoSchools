import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/comments/comments_widget.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/bloc/load_post_bloc.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post';
  final int postId;
  PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

final List<Comments_Widget> commentsList = [];

TextEditingController _commentController = TextEditingController();

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {
                //open bottom sheet model
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double
                                  .infinity, // Set width to take up the whole screen
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _commentController,
                                      decoration: InputDecoration(
                                        hintText: 'Type your comment...',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            String commentText =
                                                _commentController.text;
                                            //  logic to send the comment
                                            print('Comment: $commentText');
                                            // Updating the UI with the new comment being added to the commentsList
                                            setState(() {
                                              commentsList.insert(
                                                  0,
                                                  Comments_Widget(
                                                      commentText:
                                                          commentText));
                                              _commentController.clear();
                                            });
                                            // Close the bottom sheet
                                            Navigator.pop(context);
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor: primaryColor,
                                            child: Icon(
                                              Icons.send,
                                              color: white,
                                              size: 17,
                                            ),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30.0), //was 9.0
                                          borderSide: BorderSide(
                                            color: Color(0XFFF5F6F8),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              30.0), //was 9.0
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.comment),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<LoadPostBloc, LoadPostState>(
          builder: (context, state) {
            if (state is LoadPostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadPostLoaded) {
              return PostLoadedWidget(
                post: state.post,
              );
            }
            if (state is LoadPostInitial) {
              context
                  .read<LoadPostBloc>()
                  .add(LoadPost(postId: widget.postId.toString()));
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}

class PostLoadedWidget extends StatefulWidget {
  final LatestUpdatedPost post;
  PostLoadedWidget({
    super.key,
    required this.post,
  });

  @override
  State<PostLoadedWidget> createState() => _PostLoadedWidgetState();
}

class _PostLoadedWidgetState extends State<PostLoadedWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 240, 238, 238),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                PostImagesWidhet(post: widget.post),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.post.content!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
          Column(
            children: commentsList.isEmpty
                ? [
                    Image.asset(
                      'assets/images/cloud_1163675.png',
                      width: 100,
                    ),
                    Text('No Comments yet...')
                  ]
                : commentsList,
          ),
        ],
      ),
    );
  }

  // void _showCommentBottomSheet(BuildContext context) {}
}
