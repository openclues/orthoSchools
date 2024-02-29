import 'dart:convert';

import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../Core/colors.dart';
import '../../../../Core/network/request_helper.dart';
import '../../../../common_widgets/Post.dart';
import '../../../become_premium/presentation/be_premium_screen.dart';
import '../../../space/presentation/add_post.dart';
import '../../../space/presentation/post_screen.dart';
import '../../../space/presentation/space_screen.dart';
import '../../../verification/persentation/screens/verification_pro_request_screen.dart';
import '../../bloc/home_screen_bloc.dart';
import '../../data/models/latest_updated_posts_model.dart';

class SpacePostWidget extends StatefulWidget {
  LatestUpdatedPost post;
  final bool? isExpanded;
  bool? isHomeScreen;
  SpacePostWidget({
    super.key,
    this.isHomeScreen,
    this.isExpanded,
    required this.post,
  });

  @override
  State<SpacePostWidget> createState() => _SpacePostWidgetState();
}

// bool? isLiked;
// int? likesCount;

class _SpacePostWidgetState extends State<SpacePostWidget> {
  @override
  void initState() {
    // isLiked = widget.post.isLiked;
    // likesCount = widget.post.likesCount;
    _getUpdatedPost();
    super.initState();
  }

  _getUpdatedPost() async {
    var response = await RequestHelper.get('post/${widget.post.id}');
    if (response.statusCode == 200) {
      setState(() {
        widget.post = LatestUpdatedPost.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      });
    }
  }

  // from date to x time ago
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.grey, offset: Offset(0, 0.5), blurRadius: 1)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfilePage.routeName,
                      arguments: {
                        "userId": widget.post.user!.id,
                        "isNav": false,
                      });
                },
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: primaryColor,
                        border: Border.all(color: primaryColor),
                      ),
                      child: widget.post.user!.profileImage != null &&
                              widget.post.user!.profileImage!.isNotEmpty
                          ? Image.network(
                              "${ApiEndpoints.baseUrl}media/${widget.post.user!.profileImage!}",
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/drimage.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NameWithBadges(user: widget.post.user!),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, SpaceScreen.routeName,
                                  arguments: widget.post.space);

                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.post.spacenName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                      // height: 1.5,
                                    ),
                                  ),
                                ),
                                if (widget.post.isJoined == false)
                                  const Text(
                                    '. Join    ',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                //post time ago
                                // Spacer(),
                                Text(
                                  " . ${LocalStorage.timeAgo(DateTime.parse(widget.post.createdAt!))}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: primaryColor,
              height: 1,
            ),

            GestureDetector(
              onTap: () async {
                if (widget.isExpanded == false || widget.isExpanded == null) {
                  await Navigator.pushNamed(context, PostScreen.routeName,
                      arguments: widget.post);

                  // ignore: use_build_context_synchronously
                  // context
                  //     .read<HomeScreenBloc>()
                  //     .add(const LoadHomeScreenData());
                } else {}
              },
              child: Container(
                margin: const EdgeInsets.only(left: 0, right: 0),
                decoration: const BoxDecoration(
                    // boxShadow: ,
                    // color: Colors.white,
                    ),
                // padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: .0),
                  child: Column(
                      crossAxisAlignment: widget.post.lanugaue == 'ar'
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.post.video != null)
                          SizedBox(
                            height: 200,
                            child: YourVideoPlayerWidget(
                              videoUrl: widget.post.video!,
                            ),
                          ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        title: const Text("Post Images"),
                                        centerTitle: true,
                                      ),
                                      body: ListView(
                                        children: [
                                          if (widget.post.video != null)
                                            Container(
                                              margin: const EdgeInsets.all(9),
                                              height: 300,
                                              child: YourVideoPlayerWidget(
                                                  // key: Key(widget.post.video!),
                                                  videoUrl: widget.post.video!),
                                            ),
                                          ...widget.post.postImages!.map((e) =>
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(e.image!),
                                              )),
                                        ],
                                      ),
                                    )));
                          },
                          child: PostImagesWidhet(
                            post: widget.post,
                          ),
                        ),
                        // const SizedBox(height: 10), // Add space between widgets
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20.0,
                          ),
                          child: Text(
                            widget.post.content!,
                            // textAlign: TextAlign.end,
                            maxLines: widget.isExpanded == true ? 100 : 3,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        if (widget.post.blogPost != null)
                          ArticleCard(articlesModel: widget.post.blogPost!),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var response = await RequestHelper.get(
                                      'post/interact/?post_id=${widget.post.id}');
                                  if (response.statusCode == 200) {
                                    var data = jsonDecode(response.body);
                                    setState(() {
                                      widget.post = widget.post.copyWith(
                                          isLiked: data['isLiked'],
                                          likesCount:
                                              data['parent_likes_count']);
                                      // widget.post.isLiked = data['isLiked'];
                                      // widget.post.likesCount =
                                      //     data['parent_likes_count'];
                                    });
                                    if (context.mounted) {
                                      context.read<HomeScreenBloc>().add(
                                          UpdatePostLocally(
                                              post: widget.post,
                                              homeLoaded: context
                                                  .read<HomeScreenBloc>()
                                                  .state as HomeScreenLoaded));
                                    }
                                    // context.read<HomeScreenBloc>().add(
                                    //     UpdatePostLocally(
                                    //         post: widget.post.copyWith(
                                    //             isLiked: data['isLiked'],
                                    //             likesCount:
                                    //                 data['parent_likes_count']),
                                    //         homeLoaded: context
                                    //             .read<HomeScreenBloc>()
                                    //             .state as HomeScreenLoaded));
                                    // .homeLoaded!);
                                    // _getUpdatedPost();
                                    // setState(() {});
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_up_alt_outlined,
                                        color: widget.post.isLiked == true
                                            ? primaryColor
                                            : Colors.grey,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${widget.post.likesCount}",
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${widget.post.commentsCount}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              // if (widget.isExpanded == true)
                              //   const Row(
                              //     children: [
                              //       Icon(
                              //         IconlyLight.chat,
                              //         color: primaryColor,
                              //         size: 15,
                              //       ),
                              //       SizedBox(width: 5),
                              //       Text("see comments",
                              //           style: TextStyle(
                              //               fontSize: 15, color: Colors.grey)),
                              //     ],
                              //   ),
                              // const Spacer(),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       IconlyLight.chat,
                              //       color: primaryColor,
                              //       size: 25,
                              //     ),
                              //     const SizedBox(width: 10),
                              //     const Icon(
                              //       IconlyLight.send,
                              //       color: primaryColor,
                              //       size: 25,
                              //     ),
                              //     const SizedBox(width: 10),
                              //     GestureDetector(
                              //       onTap: () async {
                              //         var response = await RequestHelper.get(
                              //             'post/interact/?post_id=${widget.post.id}');
                              //         if (response.statusCode == 200) {
                              //           print(response.body);
                              //           setState(() {
                              //             widget.post.isLiked =
                              //                 !widget.post.isLiked!;
                              //             if (widget.post.isLiked == true) {
                              //               widget.post.likesCount = 1;
                              //             } else {
                              //               widget.post.likesCount = 0;
                              //             }
                              //           });
                              //         }
                              //       },
                              //       child: Icon(
                              //           widget.post.isLiked == true
                              //               ? IconlyBold.heart
                              //               : IconlyLight.heart,
                              //           color: widget.post.isLiked == true
                              //               ? Colors.red
                              //               : Colors.grey,
                              //           size: 25),
                              //     ),
                              //   ],
                              // ),

                              // Row(
                              //   children: [
                              //     Text(isLiked.toString(),
                              //         style: const TextStyle(
                              //             fontSize: 15, color: Colors.grey)),
                              //     const SizedBox(width: 5),
                              //     // GestureDetector(
                              //     //   onTap: () async {
                              //     //     // post.isLiked = !post.isLiked;
                              //     //     var response = await RequestHelper.get(
                              //     //         'post/interact/?post_id=${widget.post.id}');
                              //     //     if (response.statusCode == 200) {
                              //     //       setState(() {
                              //     //         isLiked = !isLiked!;
                              //     //         if (isLiked == true) {
                              //     //           likesCount = likesCount! + 1;
                              //     //         } else {
                              //     //           likesCount = likesCount! - 1;
                              //     //         }
                              //     //       });
                              //     //     }
                              //     //   },
                              //     //   child: isLiked == true
                              //     //       ? const Icon(
                              //     //           IconlyBold.heart,
                              //     //           color: Colors.red,
                              //     //           // size: 15,
                              //     //         )
                              //     //       : const Icon(
                              //     //           IconlyLight.heart,
                              //     //           color: Colors.grey,
                              //     //           // size: 15,
                              //     //         ),
                              //     // )
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //           "${widget.post.commentsCount} comments . ${widget.post.likesCount} likes",
                        //           style: const TextStyle(
                        //               fontSize: 15, color: Colors.grey)),
                        //       const Spacer(),
                        //       const Icon(
                        //         IconlyLight.time_circle,
                        //         color: primaryColor,
                        //         size: 20,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       Text(
                        //         LocalStorage.timeAgo(
                        //             DateTime.parse(widget.post.createdAt!)),
                        //         style: const TextStyle(
                        //             color: Colors.grey, fontSize: 11),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // const SizedBox(
                        //   height: 10,
                        // )
                      ]),
                ),
              ),
            ),

            // const SizedBox(height: 10), // Add space between widgets
            // Divider(thickness: 1, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}

class NameWithBadges extends StatelessWidget {
  final PostCommentUser user;

  const NameWithBadges({
    super.key,
    required this.user,
    // required this.widget,
  });

  // final SpacePostWidget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProfilePage.routeName, arguments: {
          "userId": user.id,
          "isNav": false,
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    '${user.firstName!} ${user.lastName!}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryColor
                        // height: 1.5,
                        ),
                  ),
                ),
                BagesRow(
                  isPremium: user.isPremium,
                  isVeriedPro: user.isVeriedPro!,
                ),
              ],
            ),
            // Spacer(),
            // DropdownButtonHideUnderline(
            //   child: DropdownButton<String>(
            //     icon: const Icon(Icons.more_vert),
            //     onChanged: (v) {
            //       showOptions(context);
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
            //     items: <String>['Report', 'Edit'].map((String option) {
            //       return DropdownMenuItem<String>(
            //         value: option,
            //         child: Text(option),
            //       );
            //     }).toList(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

void showOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report'),
            onTap: () {
              // Handle report action
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              // Handle edit action
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class BagesRow extends StatelessWidget {
  final bool? isVeriedPro;
  final bool? isPremium;
  const BagesRow({
    required this.isVeriedPro,
    required this.isPremium,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPremium == true)
          GestureDetector(
              onTap: () {
                //shoo dialog to explain what is premium
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Image.asset('assets/images/premium.png',
                                height: 30),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("Premium User"),
                          ],
                        ),
                        content: const Text(
                            "Premium users are users who have partnerships with the us and have access to more features and can be trusted to provide quality content."),
                        actions: [
                          if (LocalStorage.currentUser(context) != null &&
                              LocalStorage.currentUser(context)!
                                      .user!
                                      .userRole ==
                                  1)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(PartnerForm.routeName);
                                },
                                child: const Text("Upgrade to Premium",
                                    style: TextStyle(color: Colors.white))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok",
                                  style: TextStyle(color: Colors.white))),
                        ],
                      );
                    });
              },
              child: Image.asset('assets/images/verified-account.png',
                  height: 30)),
        const SizedBox(width: 5),
        if (isVeriedPro == true)
          GestureDetector(
              onTap: () {
                //show dialog to explain what is pro

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Image.asset('assets/images/quality.png',
                                height: 25),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("Verified Pro User"),
                          ],
                        ),
                        content: const Text(
                            "Verified Pro users are users who have been verified by the admin to be professionals in their field. They have access to more features and can be trusted to provide quality content."),
                        actions: [
                          // if (LocalStorage.currentUser(context) != null &&
                          //     LocalStorage.currentUser(context)!
                          //             .user!
                          //             .isVerifiedPro ==
                          //         false &&
                          //     LocalStorage.currentUser(context)!
                          //             .user!
                          //             .userRole ==
                          //         1)
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  VerificationProRequestScreen.routeName,
                                );
                              },
                              child: const Text("Request Verification",
                                  style: TextStyle(color: Colors.white))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok",
                                  style: TextStyle(color: primaryColor))),
                        ],
                      );
                    });
              },
              child: Image.asset('assets/images/quality.png', height: 25)),
      ],
    );
  }
}
