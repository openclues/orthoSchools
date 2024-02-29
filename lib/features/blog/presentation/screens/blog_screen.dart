import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/blog/bloc/cubit/blog_comments_cubit.dart';
import 'package:azsoon/features/blog/bloc/cubit/blog_cupit_cubit.dart';
import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/blog/presentation/screens/add_article.dart';
import 'package:azsoon/features/blog/presentation/screens/articles_feed.dart';
import 'package:azsoon/features/blog/presentation/screens/eachBlog.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/post_widget.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../screens/ProfilePage.dart';
import '../../../../screens/my_blog_screen.dart';
import '../../../profile/presentation/screens/create_blog_screen.dart';

class BlogScreen extends StatefulWidget {
  static const String routeName = '/blogScreen';
  final BlogsModel blog;
  const BlogScreen({super.key, required this.blog});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

late TabController _tabController;

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  bool? isFollowing = false;
  String? filter;

  @override
  Widget build(BuildContext context) {
    Profile profile =
        (context.read<ProfileBloc>().state as ProfileLoaded).profileModel;
    // CategoryModel? selectedCategory;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.blog.title!,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        floatingActionButton: profile.user!.id == widget.blog.user!.id
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => BlogCommentsCubit(),
                            child: BlocProvider(
                              create: (context) => BlogCommentsCubit(),
                              child: AddArticleScreen(blogId: widget.blog.id!),
                            ),
                          )));
                  context
                      .read<BlogCupitCubit>()
                      .loadBlogScreen(widget.blog.id!, filter);
                },
                child: const Text('Add Article',
                    style: TextStyle(fontSize: 15, color: Colors.white)))
            : const SizedBox(),
        body: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 3.0, color: primaryColor),
                        ),
                      ),
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        widget.blog.cover!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: BlocBuilder<BlogCupitCubit, BlogCupitState>(
                    builder: (context, state) {
                      if (state is BlogCupitLoaded) {
                        return profile.user!.id != widget.blog.user!.id
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () async {
                                  var response = await RequestHelper.get(
                                      'blog/followunfollow/?blog_id=${widget.blog.id}');
                                  if (response.statusCode == 200) {
                                    bool? isFollowed = jsonDecode(utf8.decode(
                                        response.bodyBytes))['is_followed'];
                                    if (context.mounted) {
                                      context
                                          .read<BlogCupitCubit>()
                                          .followunfollowLocally(isFollowed!);
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                      state.blogScreen.isFollowed == true
                                          ? 'Unfollow'
                                          : 'Follow',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            : ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlogCreationScreen(
                                              blogModel: widget.blog,
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                child: const Text("Edit Blog",
                                    style: TextStyle(color: Colors.white)));
                      } else if (state is BlogCupitLoading) {
                        return const Center();
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          // print(widget.blog.user!.userAccount.id);
                          Navigator.of(context).pushNamed(ProfilePage.routeName,
                              arguments: {
                                'userId': widget.blog.user!.id,
                                'isNav': true
                              });
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: primaryColor,
                            ),
                            // color: Colors.grey,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: widget.blog.user!.profileImage != null
                                  ? Image.network(
                                      widget.blog.user!.profileImage!,
                                      fit: BoxFit.cover)
                                  : Image.asset('assets/images/drimage.png')),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.blog.title!,
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${widget.blog.user!.userAccount.firstName} ${widget.blog.user!.userAccount.lastName!}",
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 15),
                              ),
                              BagesRow(
                                  isVeriedPro: widget
                                      .blog.user!.userAccount.isVerifiedPro,
                                  isPremium:
                                      widget.blog.user!.userAccount!.userRole ==
                                          2),
                            ],
                          ),

                          // : SizedBox()
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3.0, color: primaryColor),
                ),
              ),
            ),
            BlocBuilder<BlogCupitCubit, BlogCupitState>(
              builder: (context, state) {
                if (state is BlogCupitInitial) {
                  context
                      .read<BlogCupitCubit>()
                      .loadBlogScreen(widget.blog.id!, filter);
                  return Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          )));
                } else if (state is BlogCupitLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BlogCupitLoaded) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      top_articles(state.blogScreen),
                      const SizedBox(
                        height: 10,
                      ),
                      //horizontal list of Categories
                      if (state.blogScreen.categories.isNotEmpty)
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.blogScreen.categories.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      filter = null;
                                    });
                                    context
                                        .read<BlogCupitCubit>()
                                        .loadBlogScreen(widget.blog.id!, null,
                                            withoutloading: true);
                                    // context
                                    //     .read<BlogCupitCubit>()
                                    //     .loadBlogScreen(widget.blog.id!, filter,
                                    //         withoutloading: true);
                                    // context
                                    //     .read<BlogCupitCubit>()
                                    //     .loadBlogScreen(widget.blog.id!, null);
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 60,
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: filter == null
                                            ? primaryColor
                                            : const Color(0XFF2A2DFF)
                                                .withOpacity(0.07)
                                        // : primaryColor,
                                        ),
                                    child: Text(
                                      'All',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: filter == null
                                              ? Colors.white
                                              : primaryColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      filter = state.blogScreen
                                          .categories[index - 1].name;
                                    });

                                    context
                                        .read<BlogCupitCubit>()
                                        .loadBlogScreen(
                                            withoutloading: true,
                                            widget.blog.id!,
                                            state.blogScreen
                                                .categories[index - 1].name);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: filter ==
                                                state.blogScreen
                                                    .categories[index - 1].name
                                            ? primaryColor
                                            : const Color(0XFF2A2DFF)
                                                .withOpacity(0.07)),
                                    child: Text(
                                      state.blogScreen.categories[index - 1]
                                          .name!,
                                      style: TextStyle(
                                        color: filter ==
                                                state.blogScreen
                                                    .categories[index - 1].name
                                            ? Colors.white
                                            : primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                      if (state.blogScreen.latestUpdatedPosts.isNotEmpty &&
                          state.filtering == false)
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                state.blogScreen.latestUpdatedPosts.length,
                            itemBuilder: (context, index) {
                              return ArticleCard(
                                articlesModel:
                                    state.blogScreen.latestUpdatedPosts[index],
                              );
                            }),
                      if (state.blogScreen.latestUpdatedPosts.isEmpty &&
                          state.filtering == false)
                        const Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: Center(
                              child: Text('No articles found',
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 20))),
                        ),
                      if (state.filtering == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 40,
                                  width: 40,
                                  // margin: const EdgeInsets.only(top: 100),
                                  child: const CircularProgressIndicator(
                                    color: primaryColor,
                                  )),
                            ],
                          ),
                        )

                      // if (state.blogScreen.articles.isNotEmpty)
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ));
  }

  Widget top_articles(BlogScreenModel blogScreenModel) {
    List<ArticlesModel> posts = blogScreenModel.blogPosts;

    if (posts.isEmpty) {
      return const SizedBox();
    }
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Featured articles',
              style: TextStyle(fontSize: 18, color: primaryColor),
            ),
          ),
        ),
        if (posts.isNotEmpty)
          SizedBox(
            // margin: const EdgeInsets.all(16),
            height: 150,
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => BlogCommentsCubit(),
                              child: DetailPage(
                                article: posts[index],
                              ),
                            )));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailPage(
                    //       image: posts[index].cover,
                    //       authorImage: "",
                    //       authorName:
                    //           '${posts[index].blog!.user!.userAccount!.firstName!} ${posts[index].blog!.user!.userAccount!.lastName!}',
                    //       topicTitle: posts[index].title,
                    //       topicText: posts[index].content.toString(),
                    //       publishTime: posts[index].createdAt.toString(),
                    //     ),
                    //   ),
                    // );
                  },
                  child: PostCard(
                    post: posts[index],
                  ),
                );
              },
            ),
          ),
        if (posts.isEmpty) const Center(child: Text('')),
      ],
    );
  }

//   Container tab_sections_view() {
//     return SizedBox(
//       height: 500,
//       child: TabBarView(
//         controller: _tabController,
//         children: [
//           SizedBox(
//             height: 500,
//             child: ListView(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               children: [
//                 // top_articles(),
//                 const Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     'Other articles',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ),
//                 other_articles(),
//               ],
//             ),
//           ),
//           const Text('data'),
//           const Text('data'),
//           const Text('data'),
//         ],
//       ),
//     );
//   }
}

class ArticleCard extends StatelessWidget {
  final ArticlesModel articlesModel;
  const ArticleCard({
    super.key,
    required this.articlesModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BlogCommentsCubit(),
                  child: DetailPage(
                    article: articlesModel,
                  ),
                )));
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            articlesModel.cover != null
                ? Container(
                    height: 200, // Set the height for the cover image
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: NetworkImage(articlesModel
                            .cover!), // Replace with actual cover image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox(),
            Container(
              height: 1,
              color: primaryColor,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    articlesModel.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    articlesModel.plainText!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  // Text(
                  //   state
                  //       .blogScreen
                  //       .latestUpdatedPosts[index]
                  //       .plainText
                  //       .toString(),
                  //   maxLines: 2,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticaleWidget extends StatelessWidget {
  const ArticaleWidget({
    super.key,
    required this.articlesModel,
  });

  final ArticlesModel articlesModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => BlogCommentsCubit(),
              child: DetailPage(
                article: articlesModel,
              ),
            ),
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(15),
              // color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: primaryColor,
                          ),
                          // color: Colors.grey,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: articlesModel.cover != null
                                ? Image.network(articlesModel.cover!,
                                    fit: BoxFit.fitHeight)
                                : const SizedBox()),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articlesModel.title!,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            Text(' @${articlesModel.blog!.title}',
                                style: const TextStyle(
                                  color: primaryColor,
                                ) // Replace with your additional text
                                ),

                            Text(
                              articlesModel.plainText!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            // const SizedBox(height: 10),
                            // Text(
                            //   articlesModel.plainText!,
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: const TextStyle(
                            //     color: Colors.black54,
                            //   ),
                            // ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                articlesModel.blog!.user!.profileImage != null
                                    ? Image.network(
                                        articlesModel.blog!.user!.profileImage!,
                                        width: 20,
                                        height: 20,
                                      )
                                    : const SizedBox(),

                                const Spacer(),

                                // const SizedBox(width: 8),
                                // Text(
                                //   '${articlesModel.blog!.user!.userAccount!.firstName!} ${articlesModel.blog!.user!.userAccount!.lastName!}',
                                //   style: const TextStyle(
                                //     color: Colors.grey,
                                //   ),
                                // ),
                              ],
                            ),
                            // const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )

          // ListTile(
          //   tileColor: const Color.fromARGB(255, 252, 229, 255),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //   dense: true,
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => DetailPage(
          //           image: articlesModel.cover,
          //           authorImage: "",
          //           authorName:
          //               '${articlesModel.blog!.user!.userAccount!.firstName!} ${articlesModel.blog!.user!.userAccount!.lastName!}',
          //           topicTitle: articlesModel.title,
          //           topicText: articlesModel.content.toString(),
          //           publishTime: articlesModel.createdAt.toString(),
          //         ),
          //       ),
          //     );
          //   },
          // leading: Container(
          //   width: 90,
          //   height: 100,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //     color: Colors.grey,
          //   ),
          //   child: ClipRRect(
          //       borderRadius: BorderRadius.circular(15),
          //       child: articlesModel.cover != null
          //           ? Image.network(
          //               articlesModel.cover!,
          //               fit: BoxFit.cover,
          //             )
          //           : SizedBox()),
          // ),

          //   // Image.asset(
          //   //     atricles[index]['image'],
          //   //     fit: BoxFit.cover,
          //   //   ),
          //   title: Text(
          //     articlesModel.title!,
          //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          //   ),
          //   subtitle: Padding(
          //     padding: EdgeInsets.only(top: 12),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             articlesModel.blog!.user!.profileImage != null
          //                 ? Image.network(
          //                     articlesModel.blog!.user!.profileImage!,
          //                     width: 20,
          //                     height: 20,
          //                   )
          //                 : SizedBox(),
          //             const SizedBox(width: 8),
          //             Text(
          //               '${articlesModel.blog!.user!.userAccount!.firstName!} ${articlesModel.blog!.user!.userAccount!.lastName!}',
          //               style: const TextStyle(
          //                 color: Colors.grey,
          //               ),
          //             ),
          //           ],
          //         ),

          //         Row(
          //           children: [
          //             const Icon(
          //               Icons.timelapse_rounded,
          //               size: 15,
          //               color: Colors.grey,
          //             ),
          //             const SizedBox(width: 8),
          //             Text(
          //               articlesModel.createdAt.toString(),
          //               style: const TextStyle(
          //                 color: Colors.grey,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          ),
    );
  }
}

class PostCard extends StatelessWidget {
  final ArticlesModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            Image.network(
              post.cover ?? '',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                post.title ?? '',
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
