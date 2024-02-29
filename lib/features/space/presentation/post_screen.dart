import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../home_screen/bloc/home_screen_bloc.dart';
import '../../home_screen/presentation/widgets/post_widget.dart';
import '../bloc/cubit/space_post_comments_cubit.dart';
import '../join_space/bloc/join_space_bloc.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post';
  LatestUpdatedPost? post;
  // int? postId;
  PostScreen({super.key, this.post});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

TextEditingController _commentController = TextEditingController();

class _PostScreenState extends State<PostScreen> {
  // _getUpdatedPost() async {
  //   var response = await RequestHelper.get('post/${widget.postId!}');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       widget.post = LatestUpdatedPost.fromJson(
  //           jsonDecode(utf8.decode(response.bodyBytes)));
  //     });
  //   }
  // }

  final FocusNode _focusNode = FocusNode();
  bool? isReply;
  NewPostComment? replyComment;

  bool? commenting = false;
  @override
  void initState() {
    if (widget.post == null) {
      // _getUpdatedPost();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JoinSpaceBloc, JoinSpaceState>(
      listener: (context, state) {
        if (state is JoinSpaceSuccess) {
          Navigator.pushReplacementNamed(context, PostScreen.routeName,
              arguments: widget.post!.copyWith(isJoined: true));
        }
      },
      child: Scaffold(
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: widget.post!.isJoined!
              ? Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.only(bottom: 5),
                      // height: 100,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (replyComment != null)
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Replying to ${replyComment!.user!.firstName} ${replyComment!.user!.lastName}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          focusNode: _focusNode,
                                          controller: _commentController,
                                          maxLines: 5,
                                          minLines: 1,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: InputBorder.none,
                                            hintText: 'Write a comment...',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )),
                                        // const Spacer(),
                                        const Icon(
                                          IconlyLight.paper,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    commenting = true;
                                  });
                                  if (replyComment == null) {
                                    var response = await RequestHelper.post(
                                        "api/post/comment", {
                                      "post": widget.post!.id.toString(),
                                      "content": _commentController.text
                                    });
                                    setState(() {
                                      commenting = false;
                                    });
                                    // _focusNode!.unfocus();

                                    if (response.statusCode == 200) {
                                      if (context.mounted) {
                                        context.read<HomeScreenBloc>().add(
                                            UpdatePostLocally(
                                                post: widget.post!.copyWith(
                                                    commentsCount: widget.post!
                                                            .commentsCount! +
                                                        1),
                                                homeLoaded: context
                                                        .read<HomeScreenBloc>()
                                                        .state
                                                    as HomeScreenLoaded));
                                        context
                                            .read<SpacePostCommentsCubit>()
                                            .addSpacePostCommentLocally(
                                                context
                                                        .read<
                                                            SpacePostCommentsCubit>()
                                                        .state
                                                    as SpacePostCommentsLoaded,
                                                NewPostComment.fromJson(
                                                    jsonDecode(utf8.decode(
                                                        response.bodyBytes))));
                                      }

                                      if (context.mounted) {
                                        // context
                                        //     .read<SpacePostCommentsCubit>()
                                        //     .addSpacePostCommentLocally(
                                        //         context
                                        //                 .read<SpacePostCommentsCubit>()
                                        //                 .state
                                        //             as SpacePostCommentsLoaded,
                                        //         comment);
                                        setState(() {});
                                      }
                                    }
                                    if (response.statusCode == 200) {
                                      _commentController.clear();
                                      _focusNode.unfocus();
                                      replyComment = null;

                                      if (context.mounted) {
                                        context.read<HomeScreenBloc>().add(
                                            UpdatePostLocally(
                                                post: widget.post!.copyWith(
                                                    commentsCount: widget.post!
                                                            .commentsCount! +
                                                        1),
                                                homeLoaded: context
                                                        .read<HomeScreenBloc>()
                                                        .state
                                                    as HomeScreenLoaded));
                                        // context
                                        //     .read<SpacePostCommentsCubit>()
                                        //     .addSpacePostCommentLocally(
                                        //         context
                                        //                 .read<
                                        //                     SpacePostCommentsCubit>()
                                        //                 .state
                                        //             as SpacePostCommentsLoaded,
                                        //         comment);
                                        setState(() {});
                                      }
                                    }
                                  } else {
                                    setState(() {
                                      commenting = true;
                                    });
                                    var response = await RequestHelper.post(
                                        "api/post/replay", {
                                      "comment": replyComment!.id.toString(),
                                      "content": _commentController.text,
                                    });
                                    setState(() {
                                      commenting = false;
                                    });
                                    if (response.statusCode == 201 ||
                                        response.statusCode == 200) {
                                      _commentController.clear();

                                      if (context.mounted) {
                                        context
                                            .read<SpacePostCommentsCubit>()
                                            .loadSpacePostComments(
                                                widget.post!.id,
                                                loading: false);
                                        setState(() {});
                                        replyComment = null;
                                      }

                                      _focusNode.unfocus();
                                    }
                                  }
                                },
                                child: commenting == true
                                    ? const CircularProgressIndicator()
                                    : const Icon(
                                        FontAwesomeIcons.paperPlane,
                                        color: primaryColor,
                                      ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          appBar: AppBar(
            // backgroundColor: Colors.grey,
            elevation: 0.5,
            title: const Text('Post'),
            centerTitle: true,
            leading: Center(
              child: IconButton(
                icon: const Icon(
                  IconlyLight.arrow_left_circle,
                  size: 35,
                  color: primaryColor,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: ListView(
            children: [
              SpacePostWidget(
                post: widget.post!,
                isExpanded: true,
              ),
              if (widget.post!.isJoined!)
                CommentsScreen(
                  post: widget.post!,
                  onOptionsChanged: (v, comment) {
                    // if (v == "Edit") {
                    //   _focusNode.requestFocus();
                    //   _commentController.text = comment!.content!;
                    // }
                  },
                  // showRepy: true,
                  postId: widget.post!.id!,
                  onTap: (v) {
                    _focusNode.requestFocus();
                    isReply = true;
                    setState(() {
                      replyComment = v;
                    });
                  },
                ),
              if (!widget.post!.isJoined!)
                const Padding(
                  padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Center(
                    child:
                        Text("You need to join the space to see the comments",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            )),
                  ),
                ),
              const SizedBox(
                height: 300,
              ),

              // PostLoadedWidget(
              //   post: widget.post!,
              // ),

              // CommentsWidget(
              //   postId: widget.post!.id!,
              // ),
            ],
          )),
    );
  }
}
