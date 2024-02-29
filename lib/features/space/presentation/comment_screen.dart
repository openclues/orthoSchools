import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/space/presentation/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../Core/common-methods.dart';
import '../../../Core/network/request_helper.dart';
import '../../blog/bloc/cubit/single_comment_cubit.dart';
import '../../home_screen/data/models/latest_updated_posts_model.dart';
import '../../home_screen/presentation/widgets/post_widget.dart';
import '../bloc/cubit/space_post_comments_cubit.dart';

class CommentScreen extends StatefulWidget {
  final int commentId;
  // final LatestUpdatedPost latestUpdatedPost;
  const CommentScreen({
    super.key,
    required this.commentId,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "back to post",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<SingleCommentCubit, SingleCommentState>(
        builder: (context, state) {
          if (state is SingleCommentInitial) {
            BlocProvider.of<SingleCommentCubit>(context)
                .loadComment(widget.commentId);
            return const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SingleCommentLoading) {
            return const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SingleCommentLoaded) {
            return SingleCommentLoadedWidget(
              comment: state.comment,
            );
          }
          return Container(
            child: const Center(
              child: Text(''),
            ),
          );
        },
      ),
    );
  }
}

class SingleCommentLoadedWidget extends StatefulWidget {
  final NewPostComment comment;

  const SingleCommentLoadedWidget({
    required this.comment,
    super.key,
  });

  @override
  State<SingleCommentLoadedWidget> createState() =>
      _SingleCommentLoadedWidgetState();
}

class _SingleCommentLoadedWidgetState extends State<SingleCommentLoadedWidget> {
  NewPostComment? replyComment;
  TextEditingController _commentController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool? commenting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 0, bottom: 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          // height: 100,

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
                        color: primaryColor.withOpacity(0.1),
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
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'Write a replay...',
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

                      setState(() {
                        commenting = true;
                      });
                      var response =
                          await RequestHelper.post("api/post/replay", {
                        "comment": widget.comment.id.toString(),
                        "content": _commentController.text,
                      });
                      // print(response.body);
                      setState(() {
                        commenting = false;
                      });
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        PostReply comment = PostReply.fromJson(
                            jsonDecode(utf8.decode(response.bodyBytes)));

                        SpacePostCommentsLoaded cot = context
                            .read<SpacePostCommentsCubit>()
                            .state as SpacePostCommentsLoaded;
                        context.read<SpacePostCommentsCubit>().addReplyLocally(
                            spacePostCommentsLoaded: cot,
                            comment: comment,
                            parentComment: widget.comment);
                        _commentController.clear();

                        // if (context.mounted) {
                        //   context
                        //       .read<SpacePostCommentsCubit>()
                        //       .loadSpacePostComments(widget.post.id,
                        //           loading: false);
                        //   setState(() {});
                        //   replyComment = null;
                        // }

                        _focusNode.unfocus();
                        // }
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
      body: ListView(
        children: [
          CommentWidget(
            // showReply: false,
            onOptionsChanged: (v) {},
            comment: widget.comment,
            onTap: (v) {},
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("${context.read<SpacePostCommentsCubit>().getComment(
                  widget.comment.id!,
                ).replies!.length} Replies"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: context
                .read<SpacePostCommentsCubit>()
                .getComment(widget.comment.id!)
                .replies!
                .length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommentProfileImage(
                          profileImage: context
                              .read<SpacePostCommentsCubit>()
                              .getComment(widget.comment.id!)
                              .replies![index]
                              .user!
                              .profileImage,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NameWithBadges(
                                    user: context
                                        .read<SpacePostCommentsCubit>()
                                        .getComment(widget.comment.id!)
                                        .replies![index]
                                        .user!),
                                const SizedBox(
                                  height: 5,
                                ),
                                //time ago
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                      CommonMethods.timeAgo(DateTime.parse(
                                          context
                                              .read<SpacePostCommentsCubit>()
                                              .getComment(widget.comment.id!)
                                              .replies![index]
                                              .createdAt!)),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                      context
                                          .read<SpacePostCommentsCubit>()
                                          .getComment(widget.comment.id!)
                                          .replies![index]
                                          .content!,
                                      style: const TextStyle(fontSize: 15)),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
