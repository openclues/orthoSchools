import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/notifications_service.dart';
import 'package:azsoon/features/space/presentation/comment_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/bloc/cubit/space_post_comments_cubit.dart';
import 'package:azsoon/features/space/bloc/space_bloc.dart';
import 'package:azsoon/features/space/presentation/add_post.dart';

import '../../../Core/network/request_helper.dart';
import '../../blog/bloc/cubit/single_comment_cubit.dart';
import '../../home_screen/data/models/recommended_spaces_model.dart';
import '../../home_screen/presentation/widgets/post_widget.dart';
import '../bloc/add_post_bloc.dart';
import '../bloc/cubit/load_posts_cubit.dart';
import '../bloc/my_spaces_bloc.dart';
import '../join_space/bloc/join_space_bloc.dart';
import 'comments_screen.dart';
import 'widgets/back_button_white_background.dart';

class SpaceScreen extends StatefulWidget {
  static const String routeName = "/space";
  final int id;
  RecommendedSpace? space;

  SpaceScreen({super.key, required this.id, required this.space});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  @override
  void initState() {
    // if (widget.space!.isAllowedToJoin != null &&
    //     widget.space!.isAllowedToJoin! == false) {
    //   Future.delayed(
    //     const Duration(seconds: 1),
    //     () {
    //       showDialog(
    //         barrierDismissible: false,
    //         barrierColor: Colors.black.withOpacity(0.5),
    //         context: context,
    //         builder: (context) => PopScope(
    //           canPop: false,
    //           child: AlertDialog(
    //             title: const Text('Join Space'),
    //             content: const Text(
    //                 'You are not allowed to join this space, please contact the space admin to join this space'),
    //             actions: [
    //               TextButton(
    //                   style: ButtonStyle(
    //                     backgroundColor:
    //                         MaterialStateProperty.all<Color>(primaryColor),
    //                   ),
    //                   onPressed: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                         builder: (context) => PartnerForm()));
    //                   },
    //                   child: const Text('Request premium access',
    //                       style: TextStyle(color: Colors.white))),
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text('Cancel'),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.space!.isAllowedToJoin == true) {
      context.read<SpaceBloc>().add(LoadSpace(id: widget.id));
    }
  }

  bool? leavingSpace = false;
  bool? notifiyMe = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceBloc, SpaceState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: widget.space!.isJoined == false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          context
                              .read<JoinSpaceBloc>()
                              .add(JoinSpace(spaceId: widget.space!.id!));
                        },
                        child: const Text(
                          "Join space",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                )
              : const SizedBox(),
          extendBody: true,
          // appBar: AppBar(
          //   actions: [
          //     BlocBuilder<LoadPostsCubit, LoadPostsState>(
          //       builder: (context, state) {
          //         if (state is LoadSpacePostsLoaded) {
          //           return Hero(
          //             tag: "search",
          //             child: IconButton(
          //                 onPressed: () {
          //                   Navigator.of(context).push(MaterialPageRoute(
          //                       builder: (context) => SearchSpaceScreen(
          //                             posts: state.posts.results,
          //                           )));
          //                 },
          //                 icon: const Icon(
          //                   IconlyLight.search,
          //                   color: primaryColor,
          //                 )),
          //           );
          //         } else {
          //           return const SizedBox();
          //         }
          //       },
          //     ),
          //   ],
          //   centerTitle: true,
          //   leading: IconButton(
          //     icon: const Icon(
          //       Icons.arrow_back_ios,
          //       color: primaryColor,
          //     ),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   elevation: 0,
          //   backgroundColor: Colors.white,
          //   title: Text(
          //     widget.space!.name!,
          //     style: const TextStyle(color: primaryColor, fontSize: 15),
          //   ),
          // ),
          body: BlocListener<AddPostBloc, AddPostState>(
            listener: (context, state) {
              if (state is AddPostLoading) {
                PushNotificationService.showProgressNotification();
                //show local notification loading
              } else if (state is AddPostLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Post added successfully'),
                  ),
                );
                context.read<LoadPostsCubit>().loadPosts(widget.space!.id!);
              } else if (state is AddPostError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<LoadPostsCubit>().loadPosts(widget.space!.id!);
                // setState(() {});
              },
              child: BlocListener<JoinSpaceBloc, JoinSpaceState>(
                listener: (context, state) {
                  if (state is JoinSpaceLoading) {
                  } else if (state is JoinSpaceSuccess) {
                    setState(() {
                      widget.space!.isJoined = true;
                    });

                    context.read<LoadPostsCubit>().loadPosts(widget.space!.id!);
                  }
                },
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: const Row(
                            children: [
                              // const Spacer(),
                              // leave space button
                              // if (widget.space!.isJoined == true)
                              //   ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //         shape: RoundedRectangleBorder(
                              //           side: const BorderSide(
                              //             color: Colors.red,
                              //           ),
                              //           borderRadius: BorderRadius.circular(20),
                              //         ),
                              //         backgroundColor: Colors.white,
                              //       ),
                              //       onPressed: () async {
                              //         setState(() {
                              //           leavingSpace = true;
                              //         });
                              //         var response = await RequestHelper.post(
                              //             "leavespace/?space_id=${widget.space!.id}",
                              //             {});
                              //         setState(() {
                              //           leavingSpace = false;
                              //         });
                              //         if (response.statusCode == 200) {
                              //           if (mounted) {
                              //             Navigator.of(context).pop();
                              //           }
                              //         }

                              //         // context
                              //         //     .read<SpaceBloc>()
                              //         //     .add(LeaveSpace(id: state.space.id!));
                              //       },
                              //       child: leavingSpace == false
                              //           ? const Text(
                              //               'Leave Space',
                              //               style: TextStyle(
                              //                 color: Colors.red,
                              //               ),
                              //             )
                              //           : const CircularProgressIndicator(
                              //               color: primaryColor,
                              //             )),
                              // if (widget.space!.isJoined == false)
                              //   JoinButton(
                              //     isAllowedToJoin:
                              //         widget.space!.isAllowedToJoin!,
                              //     spaceId: widget.space!.id!,
                              //     isJoined: widget.space!.isJoined!,
                              //   )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,

                              // width: double.infinity,

                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: Image.network(
                                  colorBlendMode: BlendMode.darken,
                                  color: Colors.black.withOpacity(0.3),
                                  widget.space!.cover!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Positioned(
                          top: 30,
                          left: 10,
                          child: BackButtonWhiteBackground(),
                        ),
                        Positioned(
                            top: 30,
                            right: 10,
                            child: Row(
                              children: [
                                GetNotificationsIcon(
                                  isBeingNotified: notifiyMe,
                                  notifyMe: () {
                                    setState(() {
                                      notifiyMe = !notifiyMe!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  // ignore: prefer_const_constructors
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Icon(
                                      FontAwesomeIcons.ellipsisV,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    //space name
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.space!.name!,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),

                          // const Spacer(),
                          // leave space button
                          if (widget.space!.isJoined == true)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    leavingSpace = true;
                                  });
                                  var response = await RequestHelper.post(
                                      "leavespace/?space_id=${widget.space!.id}",
                                      {});
                                  setState(() {
                                    leavingSpace = false;
                                  });
                                  if (response.statusCode == 200) {
                                    if (mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  }

                                  // context
                                  //     .read<SpaceBloc>()
                                  //     .add(LeaveSpace(id: state.space.id!));
                                },
                                child: leavingSpace == false
                                    ? const Text(
                                        'Leave Space',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      )
                                    : const CircularProgressIndicator(
                                        color: primaryColor,
                                      )),
                          // if (widget.space!.isJoined == false)
                          //   JoinButton(
                          //     isAllowedToJoin: widget.space!.isAllowedToJoin!,
                          //     spaceId: widget.space!.id!,
                          //     isJoined: widget.space!.isJoined!,
                          //   )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(widget.space!.description!,
                          style: const TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                    if (widget.space!.isJoined == true)
                      SpaceJoinedScreen(id: widget.id, space: widget.space!),
                    if (widget.space!.isJoined == false)
                      NotJoinedSpaceScreen(
                        space: widget.space!,
                      ),
                    // if (widget.space!.isJoined == true)
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: state.space.posts!.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     List<LatestUpdatedPost> posts =
                    //         state.space.posts!.reversed.toList();
                    //     posts.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                    //     return SpacePostWidget(
                    //       post: posts[index],
                    //     );
                    //   },
                    // ),
                    // space description
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SpaceJoinedScreen extends StatelessWidget {
  final int id;
  final RecommendedSpace space;
  const SpaceJoinedScreen({super.key, required this.id, required this.space});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AddPostBox(space: space),

        SpacePostsList(
          spaceId: id,
        ), //load space posts.
      ],
    );
  }
}

class AddPostBox extends StatelessWidget {
  final RecommendedSpace? space;

  const AddPostBox({
    super.key,
    required this.space,
  });

  // final SpaceScreen widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageAnimationTransition(
            pageAnimationType: BottomToTopTransition(),
            page: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => MySpacesBloc(),
                ),
                BlocProvider.value(
                  value: context.read<AddPostBloc>(),
                ),
              ],
              child: AddPostScreen(
                space: space,
              ),
            )));
        //show modal bottom sheet
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/drimage.png"),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Share your thoughts...',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        IconlyLight.paper,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetNotificationsIcon extends StatefulWidget {
  final bool? isBeingNotified;
  final void Function()? notifyMe;

  const GetNotificationsIcon({
    super.key,
    this.isBeingNotified,
    this.notifyMe,
  });

  @override
  State<GetNotificationsIcon> createState() => _GetNotificationsIconState();
}

class _GetNotificationsIconState extends State<GetNotificationsIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.notifyMe,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        // ignore: prefer_const_constructors
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Icon(
                widget.isBeingNotified == true
                    ? IconlyBold.notification
                    : IconlyLight.notification,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpacePostsList extends StatefulWidget {
  final int? spaceId;
  const SpacePostsList({super.key, required this.spaceId});

  @override
  State<SpacePostsList> createState() => _SpacePostsListState();
}

class _SpacePostsListState extends State<SpacePostsList> {
  @override
  void didChangeDependencies() {
    context.read<LoadPostsCubit>().loadPosts(widget.spaceId!, filter: 'recent');

    super.didChangeDependencies();
  }

  Map<String, dynamic> filter = {
    "Recent Posts": "recent",
    "Recent active": "most_commented",
    "Popular": "popular",
  };

  String? selectedFilter = "recent";

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              const Spacer(),
              Row(
                children: [
                  Text(
                    filter.keys.firstWhere(
                        (element) => filter[element] == selectedFilter),
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (ctx) {
                          return SizedBox(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: filter.entries
                                    .map((e) => Container(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: e.value,
                                                groupValue: selectedFilter,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedFilter =
                                                        value as String?;
                                                  });

                                                  Navigator.pop(context);

                                                  context
                                                      .read<LoadPostsCubit>()
                                                      .loadPosts(
                                                          widget.spaceId!,
                                                          filter:
                                                              selectedFilter);
                                                },
                                              ),
                                              Text(e.key),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      IconlyLight.filter,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder<LoadPostsCubit, LoadPostsState>(
            builder: (context, state) {
              if (state is LoadPostsInitial) {
                context
                    .read<LoadPostsCubit>()
                    .loadPosts(widget.spaceId!, filter: 'recent');

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LoadSpacePostsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (state is LoadSpacePostsLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.posts.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpacePostWidget(
                      post: state.posts.results[index],
                      isExpanded: false,
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          // BlocBuilder<LoadSpaceOistsBloc, LoadSpaceOistsState>(
          //   builder: (context, state) {
          //     if (state is LoadSpaceOistsInitial) {
          //       return Center(
          //         child: Text(state.toString()),
          //       );
          //     }
          //     if (state is LoadSpacePostsLoading) {
          //       return Center(
          //         child: Column(
          //           children: [
          //             Text(state.toString()),
          //             const CircularProgressIndicator(
          //               color: primaryColor,
          //             ),
          //           ],
          //         ),
          //       );
          //     } else if (state is LoadSpaceLoaded) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemCount: state.posts.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Text(state.posts[index].title!);
          //         },
          //       );
          //     } else {
          //       return Center(
          //         child: Text(state.toString()),
          //       );
          //     }
          // },
          // ),
        ]);
  }
}

// class PostWidgets extends StatelessWidget {
//   final LatestUpdatedPost? post;
//   const PostWidgets({
//     Key? key,
//     this.post,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print(post!.id!.toString() + "dsfpsdkfps[dfksd]");
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Post header with user information
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 20.0,
//                 backgroundImage: AssetImage('assets/profile_picture.jpg'),
//               ),
//               const SizedBox(width: 8.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${post!.user!.firstName!} ${post!.user!.lastName!}",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     //time ago from created at
//                     CommonMethods.timeAgo(DateTime.parse(post!.createdAt!)),
//                     style: const TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 12.0),
//           // Post content
//           Text(post!.content!),
//           const SizedBox(height: 12.0),
//           // Post image
//           PostImagesWidhet(post: post!),
//           const SizedBox(height: 12.0),
//           // Like, comment, and share buttons
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushNamed(CommentsScreen.routeName, arguments: post!.id);
//                 },
//                 child: Row(
//                   children: [
//                     const Icon(
//                       IconlyBold.chat,
//                       color: primaryColor,
//                     ),
//                     const SizedBox(width: 4.0),
//                     Text(
//                       'Comment ${post!.commentsCount}',
//                       style: const TextStyle(color: primaryColor),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   const Icon(  IconlyBold.heart, color: primaryColor),
//                   const SizedBox(width: 4.0),
//                   Text('${post!.likesCount}'),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class CommentsScreen extends StatefulWidget {
//  final bool? showRepy;
  LatestUpdatedPost post;
  void Function(NewPostComment comment)? onTap;
  final int? postId;
  static const String routeName = "/comments";
  CommentsScreen(
      {Key? key,
      required this.onTap,
      this.postId,
      // required this.showRepy,
      required this.post})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    context.read<SpacePostCommentsCubit>().loadSpacePostComments(widget.postId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpacePostCommentsCubit, SpacePostCommentsState>(
      builder: (context, state) {
        if (state is SpacePostCommentsInitial) {
          context
              .read<SpacePostCommentsCubit>()
              .loadSpacePostComments(widget.postId);
          return const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SpacePostCommentsLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SpacePostCommentsLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Comments (${state.comments.length})",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return BlocProvider(
                          create: (context) => SingleCommentCubit(),
                          child: CommentScreen(
                            latestUpdatedPost: widget.post,
                            commentId: state.comments[index].id!,
                            // postId: state.comments[index].id,
                            // showRepy: true,
                          ),
                        );
                      }));
                    },
                    child: Container(
                      child: CommentWidget(
                        // showReply: widget.showRepy ?? false,
                        comment: state.comments[index],
                        onTap: (v) => widget.onTap!(v),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}

class NotJoinedSpaceScreen extends StatelessWidget {
  RecommendedSpace space;
  NotJoinedSpaceScreen({super.key, required this.space});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        // Text("Space details", style: TextStyle(fontWeight: FontWeight.bold)),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text("Members ( ${space.membersCount} )",
                style: const TextStyle(fontWeight: FontWeight.normal))),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          height: 50,
          // width: 500,
          child: Stack(
            children: space.members!
                .map(
                  (e) => Positioned(
                    left: space.members!.indexOf(e) *
                        30.0, // Adjust the spacing between avatars
                    child: e.profileImage == null || e.profileImage!.isEmpty
                        ? CircleAvatar(
                            // radius: 20.0,
                            child: Text(""),
                          )
                        : ClipOval(
                            child: SizedBox(
                              width:
                                  40.0, // Set the width and height to make it a circle
                              height: 40.0,
                              child: Image.network(
                                '${ApiEndpoints.baseUrl}media/${e.profileImage!}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Categories (${space.category!.length})",
          ),
        ),
        Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            verticalDirection: VerticalDirection.down,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            direction: Axis.horizontal,
            runSpacing: 10, // Set the runSpacing to the desired value
            children: space.category!
                .map(
                  (e) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize
                              .min, // Added to make the row take minimum width
                          children: [
                            Text(
                              e.name!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: '${e.image}',
                                height: 40,
                                width: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
        //posts count
      ],
    );
  }
}
