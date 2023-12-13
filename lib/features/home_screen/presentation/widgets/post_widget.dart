import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../Core/colors.dart';
import '../../../../widgets/Navigation-Drawer.dart';
import '../../../../widgets/Post.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../space/presentation/post_screen.dart';
import '../../../space/presentation/space_screen.dart';
import '../../data/models/latest_updated_posts_model.dart';

class SpacePostWidget extends StatelessWidget {
  final LatestUpdatedPost post;

  const SpacePostWidget({
    super.key,
    required this.post,
  });
  // from date to x time ago
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} years ago";
    if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} months ago";
    if (diff.inDays > 7) return "${(diff.inDays / 7).floor()} weeks ago";
    if (diff.inDays > 0) return "${diff.inDays} days ago";
    if (diff.inHours > 0) return "${diff.inHours} hours ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes} minutes ago";
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 0),
          decoration: const BoxDecoration(
            // boxShadow: ,
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              // bottomLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 0.5,
                offset: Offset(0.1, 0.1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName,
                    arguments: true);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: post.user!.profileImage != null
                        ? Image.network(post.user?.profileImage ?? '').image
                        : const AssetImage('assets/images/drimage.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr.${post.user!.firstName!} ${post.user!.lastName!}',
                          style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 0.5),
                                        blurRadius: 1)
                                  ],
                                ),
                                child: Image.asset('assets/images/premium.png',
                                    height: 25)),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 0.5),
                                      blurRadius: 1)
                                ],
                              ),
                              child: Image.asset(
                                  'assets/images/verified-account.png',
                                  height: 25),
                            ),
                          ],
                        )
                        // ignore: prefer_const_constructors
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PostScreen.routeName,
                arguments: post.id);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 0),
            decoration: const BoxDecoration(
              // boxShadow: ,
              color: Colors.white,
              borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 0.5,
                  offset: Offset(0.1, 0.1), // changes position of shadow
                ),
              ],
            ),
            // padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (post.user != null && )

                    ListTile(
                      trailing: Column(
                        children: [
                          if (post.isJoined == true)
                            const Icon(IconlyLight.more_circle,
                                color: Colors.grey),
                          // Icon(Icons.more_vert),
                          JoinButton(
                            isJoined: post.isJoined!,
                            spaceId: post.space!,
                            // space: post.space!,
                            isAllowedToJoin: post.isAllowedToJoin!,
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          Text(
                            timeAgo(DateTime.parse(post.createdAt!)),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11),
                          ),
                          // const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SpaceScreen.routeName,
                                    arguments: post.space);
                              },
                              child: Text(
                                ' in ${post.spacenName}',
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // title: Text(
                      //     "${moreInfoUserProvider.user.speciality}  ${userProvider.user.firstName}"),
                    ),
                    PostImagesWidhet(
                      post: post,
                    ),
                    const SizedBox(height: 10), // Add space between widgets
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.content!,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15), // Add space between widgets

                    Row(
                      children: [
                        Text("see comments ( ${post.comments!.length} )",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey)),
                        const Spacer(),
                        const Row(
                          children: [
                            Icon(
                              IconlyLight.chat,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              IconlyBold.heart,
                              color: Colors.red,
                              // size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add space between widgets
                  ]),
            ),
          ),
        ),

        // const SizedBox(height: 10), // Add space between widgets
        Divider(thickness: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
