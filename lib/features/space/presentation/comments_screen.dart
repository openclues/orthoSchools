import 'dart:convert';

import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/post_widget.dart';
import 'package:azsoon/features/space/bloc/cubit/space_post_comments_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../Core/colors.dart';
import '../../../Core/common-methods.dart';
import '../../../Core/network/request_helper.dart';
import '../../home_screen/data/models/latest_updated_posts_model.dart';

class CommentWidget extends StatefulWidget {
  final NewPostComment? comment;
  final bool? isAricleComment;
  // bool? showReply;
  Function(String?)? onOptionsChanged;
  final PostReply? reply;
  final int? postId;
  final isFullScreen;
  final bool isReply;

  void Function(NewPostComment comment)? onTap;

  CommentWidget({
    super.key,
    this.postId,
    this.comment,
    this.isAricleComment,
    this.isFullScreen = false,
    this.isReply = false,
    required this.onTap,
    required this.onOptionsChanged,
    this.reply,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showReplies = false;
  @override
  void initState() {
    // showReplies = widget.showReply ?? false;
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? editing = false;
  bool? updating = false;
  final FocusNode? _focusNode = FocusNode();
  String? newComment;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Text(widget.comment!.user!.firstName!),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //profile image
              CommentProfileImage(
                profileImage: widget.reply == null
                    ? widget.comment!.user!.profileImage
                    : widget.reply!.user!.profileImage,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //first name and last name
                  children: [
                    //first name and last name
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.reply == null
                                ? "${widget.comment!.user!.firstName ?? ""} ${widget.comment!.user!.lastName ?? ""}"
                                : "${widget.reply!.user!.firstName ?? ""} ${widget.reply!.user!.lastName ?? ""}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: primaryColor
                                // height: 1.5,
                                ),
                          ),
                        ),
                        Container(
                          child: BagesRow(
                            isPremium: widget.comment!.user!.isPremium,
                            isVeriedPro: widget.comment!.user!.isVeriedPro,
                          ),
                        ),
                        //time
                        // const SizedBox(width: 8.0),

                        // const Spacer(),
                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton<String>(
                        //     icon: const Icon(Icons.more_vert),
                        //     onChanged: (String? newValue) {
                        //       // widget.onOptionsChanged!(newValue);
                        //       if (newValue == 'Edit') {
                        //         setState(() {
                        //           editing = true;
                        //         });
                        //         _focusNode!.requestFocus();
                        //       }
                        //     },
                        //     // value: _selectedOption,
                        //     // onChanged: (String newValue) {
                        //     //   setState(() {
                        //     //     _selectedOption = newValue;
                        //     //     // Perform action based on selected option
                        //     //     if (_selectedOption == 'Report') {
                        //     //       // Handle report action
                        //     //     } else if (_selectedOption == 'Edit') {
                        //     //       // Handle edit action
                        //     //     }
                        //     //   });
                        //     // },
                        //     items:
                        //         <String>['Remove', 'Edit'].map((String option) {
                        //       return DropdownMenuItem<String>(
                        //         value: option,
                        //         child: Text(option),
                        //       );
                        //     }).toList(),
                        //   ),
                        // )
                      ],
                    ),
                    Text(
                      CommonMethods.timeAgo(widget.reply == null
                          ? DateTime.parse(widget.comment!.createdAt!)
                          : DateTime.parse(widget.reply!.createdAt!)),
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    const SizedBox(height: 4.0),
                    //comment content
                    if (editing == false)
                      Text(
                        widget.reply == null
                            ? widget.comment!.content ?? ""
                            : widget.reply!.content ?? "",
                        style: const TextStyle(fontSize: 12.0),
                        // maxLines: 3,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    if (editing == true)
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          onSaved: (c) {
                            setState(() {
                              newComment = c;
                            });
                          },
                          focusNode: _focusNode,
                          initialValue: widget.reply == null
                              ? widget.comment!.content ?? ""
                              : widget.reply!.content ?? "",
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),

                            // labelText: 'Edit comment',
                          ),
                        ),
                      ),
                    const SizedBox(height: 15.0),
                    //reply and like
                    if (widget.isReply == false &&
                        widget.isAricleComment != true)
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(IconlyLight.chat,
                                color: primaryColor, size: 20.0),
                            const SizedBox(width: 4.0),
                            Text(
                              '${widget.comment!.replies!.length}',
                              style: const TextStyle(
                                  color: primaryColor, fontSize: 14.0),
                            ),
                            const SizedBox(width: 20.0),
                            InkWell(
                              onTap: () async {
                                var response = await RequestHelper.get(
                                    'comment/interact/?comment_id=${widget.comment!.id}');
                                // print(response.body);
                                if (response.statusCode == 200) {
                                  var decodedResponse = jsonDecode(
                                      utf8.decode(response.bodyBytes));
                                  setState(() {
                                    widget.comment!.isLiked =
                                        decodedResponse['isLiked'];
                                    widget.comment!.likes =
                                        decodedResponse['parent_likes_count'];
                                  });
                                }
                              },
                              child: widget.comment!.isLiked == true
                                  ? const Icon(
                                      IconlyBold.heart,
                                      size: 20.0,
                                      color: primaryColor,
                                    )
                                  : const Icon(
                                      IconlyLight.heart,
                                      size: 20.0,
                                      color: Colors.grey,
                                    ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              // onTap: () => widget.onTap!(widget.comment!),
                              child: Text(widget.comment!.likes.toString(),
                                  style: const TextStyle(
                                      color: primaryColor, fontSize: 14.0)),
                            ),
                            const SizedBox(width: 20.0),
                            if (editing == true)
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          editing = false;
                                        });
                                      },
                                      child: const Text("Cancel",
                                          style:
                                              TextStyle(color: Colors.white))),
                                  const SizedBox(width: 8.0),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          if (newComment != null &&
                                              newComment!.isNotEmpty) {
                                            setState(() {
                                              updating = true;
                                            });
                                            var response =
                                                await RequestHelper.post(
                                                    'comment/update/', {
                                              'comment_id':
                                                  widget.comment!.id.toString(),
                                              'content': newComment
                                            });

                                            setState(() {
                                              updating = false;
                                            });
                                            if (response.statusCode == 200) {
                                              // context.read<SpacePostCommentsCubit>().loadSpacePostComments(
                                              //     widget.comment!);
                                            }
                                          }
                                        }
                                      },
                                      child: const Text("Update",
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                              )
                          ],
                        ),
                      ),
                    if (widget.isReply == false)
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      )
                  ],
                ),
              )
            ],
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       // const Spacer(),
        //       Padding(
        //         padding: const EdgeInsets.all(0),
        //         child: CircleAvatar(
        //           backgroundColor: primaryColor,
        //           child: widget.isReply == false
        //               ? (widget.comment!.user!.profileImage != null
        //                   ? ClipRRect(
        //                       borderRadius: BorderRadius.circular(50),
        //                       child: Image.network(
        //                         "${ApiEndpoints.baseUrl}media/${widget.comment!.user!.profileImage!}",
        //                         fit: BoxFit.cover,
        //                         width: 50,
        //                         height: 50,
        //                       ),
        //                     )
        //                   : Image.asset('assets/images/drimage.png'))
        //               : (widget.reply!.user!.profileImage != null
        //                   ? CircleAvatar(
        //                       child: Image.network(
        //                       "${ApiEndpoints.baseUrl}media/${widget.reply!.user!.profileImage!}",
        //                     )
        //                       // Your CircleAvatar properties for replies
        //                       )
        //                   : Image.asset('assets/images/drimage.png')),
        //         ),
        //       ),
        //       Expanded(
        //         child: Container(
        //           margin: const EdgeInsets.only(
        //               // left: 0.0,
        //               // right: 8.0,
        //               // top: 8.0,
        //               // bottom: 8.0,
        //               ),
        //           padding: const EdgeInsets.all(12.0),
        //           decoration: BoxDecoration(
        //             color: widget.isReply ? Colors.grey[50] : Colors.grey[100],
        //             borderRadius: BorderRadius.circular(12.0),
        //             // boxShadow: [],
        //           ),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               // if (widget.isReply) RoundedLine(),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         widget.reply == null
        //                             ? "${widget.comment!.user!.firstName!} ${widget.comment!.user!.lastName!}"
        //                             : "${widget.reply!.user!.firstName!} ${widget.reply!.user!.lastName!}",
        //                         style: const TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 14.0,
        //                         ),
        //                       ),
        //                       const SizedBox(height: 4.0),
        //                       Text(
        //                         CommonMethods.timeAgo(widget.reply == null
        //                             ? DateTime.parse(widget.comment!.createdAt!)
        //                             : DateTime.parse(widget.reply!.createdAt!)),
        //                         style: const TextStyle(
        //                             color: Colors.grey, fontSize: 10.0),
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //               const SizedBox(height: 4.0),
        //               Text(
        //                 widget.reply == null
        //                     ? widget.comment!.content ?? ""
        //                     : widget.reply!.content ?? "",
        //                 style: const TextStyle(fontSize: 12.0),
        //                 maxLines: 3,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //               const SizedBox(height: 6.0),

        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.end,
        //                 children: [
        //                   Row(
        //                     children: [
        //                       if (widget.reply == null &&
        //                           widget.comment!.replies!.isNotEmpty)
        //                         ElevatedButton(
        //                           onPressed: () {
        //                             setState(() {
        //                               showReplies = !showReplies;
        //                             });
        //                             //scroll to the bottom of the screen
        //                             // _scrollController.animateTo(
        //                             //   _scrollController.position.maxScrollExtent,
        //                             //   duration: const Duration(milliseconds: 300),
        //                             //   curve: Curves.easeOut,
        //                             // );
        //                           },
        //                           style: ElevatedButton.styleFrom(
        //                             shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(10),
        //                             ),
        //                             backgroundColor: Colors.grey[200],
        //                           ),
        //                           child: Text(
        //                             showReplies
        //                                 ? 'Hide Replies'
        //                                 : 'Show Replies',
        //                             style: TextStyle(
        //                                 color: Colors.grey[700],
        //                                 fontSize: 10.0),
        //                           ),
        //                         ),
        //                       const SizedBox(width: 8.0),
        //                       // GestureDetector(
        //                       //   onTap: () async {
        //                       //     context.read<LikeCubitCubit>().likeUnlike(
        //                       //         widget.comment.id,
        //                       //         ObjectTypeContent.COMMENT);
        //                       // var response = await RequestHelper.get(
        //                       //   "comment/interact/?comment_id=${widget.comment.id}",
        //                       // );
        //                       // if (response.statusCode == 200) {
        //                       //   Comment comment = Comment.fromJson(
        //                       //       jsonDecode(
        //                       //           utf8.decode(response.bodyBytes)));
        //                       //   if (context.mounted) {
        //                       //     // context
        //                       //     //     .read<SpacePostCommentsCubit>()
        //                       //     //     .addSpacePostCommentLocally(
        //                       //     //         context
        //                       //     //                 .read<
        //                       //     //                     SpacePostCommentsCubit>()
        //                       //     //                 .state
        //                       //     //             as SpacePostCommentsLoaded,
        //                       //     //         comment);
        //                       //     widget.comment.copyWith(
        //                       //         commentLikes: comment.commentLikes);

        //                       //     setState(() {});
        //                       //   }
        //                       // }

        //                       // if (response.statusCode == 201) {
        //                       //   _commentController.clear();
        //                       //   Comment comment = Comment.fromJson(
        //                       //       jsonDecode(utf8.decode(response.bodyBytes)));
        //                       //   context.read<SpacePostCommentsCubit>().addSpacePostCommentLocally(
        //                       //       context.read<SpacePostCommentsCubit>().state as SpacePostCommentsLoaded,
        //                       //       comment);
        //                       // }
        //                       //   },
        //                       //   child:
        //                       //       BlocBuilder<LikeCubitCubit, LikeCubitState>(
        //                       //     builder: (context, state) {
        //                       //       Widget likestring() {
        //                       //         if (state is LikeLoading) {
        //                       //           return CircularProgressIndicator();
        //                       //         }
        //                       //         if (state is LikeLoaded) {
        //                       //           return Text(
        //                       //               '${state.likesCount} ${state.likesCount == 1 ? 'Like' : 'Likes'}',
        //                       //               style: const TextStyle(
        //                       //                   color: Colors.grey,
        //                       //                   fontSize: 10.0));
        //                       //         } else {
        //                       //           return Text(
        //                       //               '${widget.comment.commentLikes} ${widget.comment.commentLikes == 1 ? 'Like' : 'Likes'}',
        //                       //               style: const TextStyle(
        //                       //                   color: Colors.grey,
        //                       //                   fontSize: 10.0));
        //                       //         }
        //                       //       }

        //                       //       return Row(
        //                       //         children: [
        //                       //           const Icon(IconlyBold.heart,
        //                       //               size: 20.0, color: primaryColor),
        //                       //           const SizedBox(width: 4.0),
        //                       //           likestring()
        //                       //         ],
        //                       //       );
        //                       //     },
        //                       //   ),
        //                       // ),
        //                     ],
        //                   ),
        //                   widget.isReply == false
        //                       ? Row(
        //                           mainAxisAlignment: MainAxisAlignment.end,
        //                           children: [
        //                             GestureDetector(
        //                                 onTap: () async {
        //                                   if (widget.comment!.isLiked == true) {
        //                                     setState(() {
        //                                       widget.comment!.isLiked = false;
        //                                       // widget.comment!.commentLikes = widget.comment!.commentLikes! - 1;
        //                                       // });
        //                                     });
        //                                   } else {
        //                                     setState(() {
        //                                       widget.comment!.isLiked = true;
        //                                       // widget.comment!.commentLikes = widget.comment!.commentLikes! + 1;
        //                                       // });
        //                                     });
        //                                   }
        //                                 },
        //                                 child: widget.comment!.isLiked == true
        //                                     ? const Icon(
        //                                         IconlyBold.heart,
        //                                         color: primaryColor,
        //                                       )
        //                                     : const Icon(
        //                                         IconlyLight.heart,
        //                                         color: Colors.grey,
        //                                       )),
        //                             const SizedBox(
        //                               width: 10,
        //                             ),
        //                             GestureDetector(
        //                               onTap: () =>
        //                                   widget.onTap!(widget.comment!),
        //                               child: const Text('Reply',
        //                                   style: TextStyle(
        //                                       color: primaryColor,
        //                                       fontSize: 14.0)),
        //                             ),
        //                           ],
        //                         )
        //                       : Container(),
        //                 ],
        //               ),
        //               if (widget.isReply)
        //                 Row(
        //                   children: [
        //                     const Spacer(),
        //                     GestureDetector(
        //                       onTap: () async {
        //                         var response = await RequestHelper.get(
        //                             'replay/interact/?reply_id=${widget.reply!.id}');
        //                         print(response.body);
        //                       },
        //                       child: Icon(widget.reply!.isLiked == true
        //                           ? IconlyBold.heart
        //                           : IconlyLight.heart),
        //                     ),
        //                   ],
        //                 )

        //               // Display replies count and show/hide button
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),

        //   // if (widget.isReply) RoundedLine(),
        // ),

        // if (widget.reply == null &&
        //     widget.comment!.replies!.isNotEmpty &&
        //     showReplies)
        // Column(
        //   children: [
        //     const SizedBox(height: 6.0),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Text(
        //       '${widget.comment!.replies!.length} ${widget.comment!.replies!.length == 1 ? 'Reply' : 'Replies'}',
        //       style: const TextStyle(color: Colors.grey, fontSize: 10.0),
        //     ),
        //     const SizedBox(width: 8.0),
        //   ],
        // ),
        // Display replies if showReplies is true
        // if (showReplies)
        //   Column(
        //     children: widget.comment!.replies!
        //         .map(
        //           (reply) => CommentWidget(
        //             showReply: true,
        //             comment: null,
        //             reply: reply,
        //             isReply: true,
        //             onTap: (v) {
        //             },
        //           ),
        //         )
        //         .toList(),
        //   ),
        //   ],
        // ),
      ],
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class CommentProfileImage extends StatelessWidget {
  final String? profileImage;
  const CommentProfileImage({
    super.key,
    required this.profileImage,
    // required this.widget,
  });

  // final CommentWidget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
          backgroundColor: primaryColor,
          child: (profileImage != null && profileImage!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "${ApiEndpoints.baseUrl}media/$profileImage",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                )
              : Image.asset('assets/images/drimage.png'))),
    );
  }
}
