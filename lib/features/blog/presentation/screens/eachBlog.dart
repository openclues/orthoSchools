import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/features/blog/bloc/cubit/blog_comments_cubit.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/space/bloc/my_spaces_bloc.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../../../space/bloc/add_post_bloc.dart';
import '../../../space/presentation/add_post.dart';
import '../../data/models/articles_model.dart';

class DetailPage extends StatefulWidget {
  final ArticlesModel article;

  const DetailPage({
    super.key,
    required this.article,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // late QuillController _controller;

  @override
  void initState() {
    print(widget.article.id);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<BlogCommentsCubit>().loadComments(widget.article.id);

    super.didChangeDependencies();
  }

  bool? showCommentField = false;

  @override
  Widget build(BuildContext context) {
    final viewInsets = EdgeInsets.fromViewPadding(
        View.of(context).viewInsets, View.of(context).devicePixelRatio);

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Set this to true to avoid the bottom navigation bar being covered by the keyboard

      bottomNavigationBar: showCommentField == false
          ? Container(
              // height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: primaryColor, offset: Offset(0, 2), blurRadius: 5)
                ],
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<BlogCommentsCubit, BlogCommentsState>(
                  builder: (context, state) {
                    if (state is BlogCommentsLoaded) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                showCommentField = true;
                              });
                              await showModalBottomSheet(
                                  transitionAnimationController:
                                      AnimationController(
                                          vsync: Navigator.of(context),
                                          duration: const Duration(
                                              milliseconds: 500)),
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        height: 800,
                                        padding: EdgeInsets.only(
                                            bottom: viewInsets.bottom),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  state.blogComments.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(state
                                                      .blogComments[index]
                                                      .text),
                                                );
                                              },
                                            ),
                                            // Spacer(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  // Comment input field
                                                  const Expanded(
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Add a comment...',
                                                      ),
                                                    ),
                                                  ),

                                                  // Submit icon
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.send),
                                                    onPressed: () {
                                                      // Perform your action on comment submission
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                              setState(() {
                                showCommentField = false;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        IconlyLight.chat,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Comments (${state.blogComments.length})",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<BlogCommentsCubit>()
                                  .likeArticle(widget.article.id, state);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: const Offset(0, 2),
                                        blurRadius: 5)
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        state.articleLikes.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        state.isLiked == true
                                            ? IconlyBold.heart
                                            : IconlyLight.heart,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                //show bottom sheet for user to choose betwween sharing the blog in a space post or to other applications

                                showModalBottomSheet(
                                    context: context,
                                    builder: ((_) {
                                      return Container(
                                          // height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 5)
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                onTap: () async {
                                                  print(widget.article.title);
                                                  await Navigator.of(context).push(
                                                      PageAnimationTransition(
                                                          pageAnimationType:
                                                              BottomToTopTransition(),
                                                          page:
                                                              MultiBlocProvider(
                                                            providers: [
                                                              BlocProvider(
                                                                create: (context) =>
                                                                    MySpacesBloc(),
                                                              ),
                                                              BlocProvider(
                                                                create: (context) =>
                                                                    AddPostBloc(),
                                                              ),
                                                            ],
                                                            child: AddPostScreen(
                                                                article: widget
                                                                    .article),
                                                          )));
                                                },
                                                leading: const Icon(
                                                  FontAwesomeIcons.spaceShuttle,
                                                  color: primaryColor,
                                                ),
                                                title: const Text(
                                                    "Share to Space"),
                                              ),
                                              const ListTile(
                                                leading: Icon(
                                                  FontAwesomeIcons.facebook,
                                                  color: primaryColor,
                                                ),
                                                title:
                                                    Text("Share to Facebook"),
                                              ),
                                              const ListTile(
                                                leading: Icon(
                                                  FontAwesomeIcons.twitter,
                                                  color: primaryColor,
                                                ),
                                                title: Text("Share to Twitter"),
                                              ),
                                              const ListTile(
                                                leading: Icon(
                                                  FontAwesomeIcons.whatsapp,
                                                  color: primaryColor,
                                                ),
                                                title:
                                                    Text("Share to Whatsapp"),
                                              ),
                                              const ListTile(
                                                leading: Icon(
                                                  FontAwesomeIcons.telegram,
                                                  color: primaryColor,
                                                ),
                                                title:
                                                    Text("Share to Telegram"),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  //convert post delta to plain text
                                                  // COPY
                                                  // Clipboard.setData(
                                                  //     ClipboardData(
                                                  //         text: _controller
                                                  //             .document
                                                  //             .toPlainText()));
                                                },
                                                leading: const Icon(
                                                  FontAwesomeIcons.copy,
                                                  color: primaryColor,
                                                ),
                                                title: const Text(
                                                    "Copy post text"),
                                              ),
                                            ],
                                          ));
                                    }));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(0, 2),
                                          blurRadius: 5)
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          IconlyLight.send,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }),
                        ],
                      );
                    } else if (state is BlogCommentsLoading) {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator()),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            )
          : const SizedBox(),
      appBar: AppBar(
        title: const Text(
          "Article",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
        child: ListView(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: widget.article.cover != null
                      ? Image.network(
                          widget.article.cover!,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox()),
            ), //should be network
            const SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.routeName, arguments: {
                  "userId": widget.article.blog!.user!.id!,
                  "isNav": false,
                });
              },
              child: Row(
                children: [
                  const Text("By ",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  Text(
                    "@${widget.article.blog!.user!.userAccount!.firstName!}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Text("Published on ",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      BlogScreen.routeName,
                      arguments: widget.article.blog!,
                    );
                  },
                  child: Text(
                    widget.article.blog!.title!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: primaryColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    widget.article.title!,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse_rounded,
                        size: 15,
                        color: primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        CommonMethods.timeAgo(DateTime.parse(
                            widget.article.createdAt!.toString())),
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.article.plainText!,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
