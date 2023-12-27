import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/comments/comments_widget.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/bloc/load_post_bloc.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../comments/comment_model.dart' as cm;

class PostScreen extends StatefulWidget {
  static const routeName = '/post';
  final LatestUpdatedPost post;
  const PostScreen({super.key, required this.post});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

TextEditingController _commentController = TextEditingController();

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
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
                              padding: const EdgeInsets.all(.0),
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
                                              //
                                            });
                                            // Close the bottom sheet
                                            Navigator.pop(context);
                                          },
                                          icon: const CircleAvatar(
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
                                          borderSide: const BorderSide(
                                            color: Color(0XFFF5F6F8),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
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
              icon: const Icon(Icons.comment),
            ),
          ],
        ),
        appBar: AppBar(
          // backgroundColor: Colors.grey,
          elevation: 0.5,
          title: const Text('Post'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            PostLoadedWidget(
              post: widget.post,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            CommentsWidget(
              postId: widget.post.id!,
            ),
          ],
        ));
  }
}

class CommentsWidget extends StatelessWidget {
  final int postId;
  const CommentsWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadPostBloc, LoadPostState>(
      builder: (context, state) {
        if (state is LoadPostInitial) {
          context
              .read<LoadPostBloc>()
              .add(LoadPostComments(postId: postId.toString()));
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadPostCommentsLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.comments.results.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(state.comments.results[index].text),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    ),
                  ),

                  // subtitle: Ro2
                );
              });
        }
        return Container();
      },
    );
  }
}

class PostLoadedWidget extends StatefulWidget {
  final LatestUpdatedPost post;
  const PostLoadedWidget({
    super.key,
    required this.post,
  });

  @override
  State<PostLoadedWidget> createState() => _PostLoadedWidgetState();
}

class _PostLoadedWidgetState extends State<PostLoadedWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          // color: const Color.fromARGB(255, 240, 238, 238),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              const PostHeaderWidget(),
              PostImagesWidhet(post: widget.post),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.post.content!,
                      style: const TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        // Column(
        //   children: commentsList.isEmpty
        //       ? [
        //           Image.asset(
        //             'assets/images/cloud_1163675.png',
        //             width: 100,
        //           ),
        //           const Text('No Comments yet...')
        //         ]
        //       : commentsList,
        // ),
      ],
    );
  }

  // void _showCommentBottomSheet(BuildContext context) {}
}

class PostHeaderWidget extends StatelessWidget {
  const PostHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '2 hours ago',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }
}

// class CommentsScreen extends StatelessWidget {
//   final List<cm.Comment> comments;

//   CommentsScreen({super.key, required this.comments});

//   Widget _buildComment(cm.Comment comment) {
//     return ListTile(
//       title: Text(comment.text),
//       subtitle: Text(
//         'By ${comment.user.firstName} ${comment.user.lastName} on ${"d"}',
//       ),
//       // Add additional styling or UI elements as needed
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Comments: $comments');
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: comments.length,
//       itemBuilder: (BuildContext context, int index) {
//         return _buildComment(comments[index]);
//       },
//     );
//   }
// }

// class CommentTree extends StatelessWidget {
//   final List<cm.Comment> comments;
//   final Widget Function(cm.Comment) commentBuilder;
//   const CommentTree(
//       {super.key, required this.comments, required this.commentBuilder});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300,
//       child: ListView.builder(
//         itemCount: comments.length,
//         itemBuilder: (context, index) {
//           final comment = comments[index];
//           return CommentNode(
//             comment: comment,
//             childBuilder: (context, child) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   commentBuilder(comment),
//                   if (child != null) child,
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class CommentNode extends StatelessWidget {
//   final cm.Comment comment;
//   final Widget Function(BuildContext, Widget?) childBuilder;
//   const CommentNode(
//       {super.key, required this.comment, required this.childBuilder});

//   @override
//   Widget build(BuildContext context) {
//     return CommentTree(
//       comments: comment.comments,
//       commentBuilder: (comment) {
//         return childBuilder(context, commentBuilder(comment));
//       },
//     );
//   }

//   commentBuilder(comment) {
//     return ListTile(
//       title: Text(comment.text),
//       subtitle: Text(
//         'By ${comment.user.firstName} ${comment.user.lastName} on ${"d"}',
//       ),
//       // Add additional styling or UI elements as needed
//     );
//   }
// }
