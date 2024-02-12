import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/categories/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../Core/colors.dart';
import '../../../../Core/local_storage.dart';
import '../../../../Core/network/endpoints.dart';
import '../../../blog/bloc/cubit/articales_cubit_cubit.dart';
import '../../../blog/data/models/blog_model.dart';
import '../../../blog/presentation/screens/blog_post_screen.dart';

class HomeScreebBlogTab extends StatefulWidget {
  const HomeScreebBlogTab({super.key});

  @override
  State<HomeScreebBlogTab> createState() => _HomeScreebBlogTabState();
}

class _HomeScreebBlogTabState extends State<HomeScreebBlogTab> {
  // final TabController? tabController = TabController(length: 9, vsync:TickerProvider);

  String? category;
  bool? following;
  getArticales(int? index) {
    if (index == 0) {
      // setState(() {
      following = true;
      // });
      context
          .read<ArticalesCubitCubit>()
          .loadArticles(following: following, category: category);
    }

    if (index == 1) {
      following = false;
      context
          .read<ArticalesCubitCubit>()
          .loadArticles(following: following, category: category);
    }
  }

  String selectedOption = 'All'; // Default selected option

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ArticalesCubitCubit>().state;
    if (state is ArticalesCubitInitial) {
      context
          .read<ArticalesCubitCubit>()
          .loadArticles(following: following, category: category);
    }

    // if (state is BlogsLoaded &&
    //     state.blogs.results != null &&
    //     state.blogs.results!.isNotEmpty) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          //switcher between following and all
          // list of blogs

          Row(
            children: [
              const Text(
                'Latest Articles',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Prefix icon

                  // Dropdown menu button
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 20,
                    iconEnabledColor: primaryColor,
                    value: selectedOption,
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                      getArticales(selectedOption == 'Following'
                          ? 0
                          : 1); // Set new value
                    },
                    items: <String>['All', 'Following']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),

          // Row(
          //   children: [
          //     const Text(
          //       'Latest Articles',
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     const Spacer(),
          //     ToggleSwitch(
          //       minWidth: 100.0,
          //       fontSize: 16.0,
          //       activeBgColor: [primaryColor, primaryColor.withOpacity(0.9)],
          //       activeFgColor: Colors.white,
          //       inactiveBgColor: Colors.grey[300],
          //       inactiveFgColor: Colors.grey[900],
          //       totalSwitches: 2,
          //       labels: const ['Following', 'All'],
          //       onToggle: (index) {
          //         getArticales(index);
          //       },
          //     ),

          //     //CREATE SWITCH BUTTOM BETTWEEN FLOLOWING AND ALL

          //     // Container(
          //     //     width: 100,
          //     //     height: 50,
          //     //     child: SwitchListTile(

          //     //       value: true, onChanged: (v) {}))
          //   ],
          // )

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       'Latest Articles',
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     TextButton(
          //         onPressed: () {},
          //         child: const Text(
          //           'View All',
          //           style: TextStyle(color: primaryColor),
          //         ))
          //   ],
          // ),

          // SizedBox(
          //   height: LocalStorage.getcreenSize(context).height * 0.3,
          //   child: ListView.builder(
          //     physics: const BouncingScrollPhysics(),
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: state.blogs.latest_updated_posts_model!.length,
          //     itemBuilder: (context, index) {
          //       BlogModel blog = getBlogFromId(
          //           state.blogs.latest_updated_posts_model![index].blog!,
          //           state.blogs.results!);
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.pushNamed(context, BlogPostScreen.routeName,
          //               arguments:
          //                   state.blogs.latest_updated_posts_model![index]);
          //         },
          //         child: Hero(
          //           tag: state.blogs.latest_updated_posts_model![index].id!,
          //           child: Container(
          //             width: LocalStorage.getcreenSize(context).width * 0.8,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20),
          //               color: Colors.grey[200],
          //               image: DecorationImage(
          //                 image: NetworkImage(ApiEndpoints.baseUrl +
          //                     state.blogs.latest_updated_posts_model![index]
          //                         .cover!
          //                         .replaceFirst('/', "")),
          //                 filterQuality: FilterQuality.high,
          //                 colorFilter: ColorFilter.mode(
          //                     Colors.black.withOpacity(0.7),
          //                     BlendMode.darken),
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       children: [
          //                         CircleAvatar(
          //                           backgroundImage: blog.user.profileImage !=
          //                                   null
          //                               ? NetworkImage(ApiEndpoints.baseUrl +
          //                                   blog.user.profileImage!)
          //                               : const AssetImage(
          //                                       'assets/images/drimage.png')
          //                                   as ImageProvider,
          //                         ),
          //                         const SizedBox(
          //                           width: 10,
          //                         ),
          //                         Expanded(
          //                           child: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                 blog.title!,
          //                                 maxLines: 2,
          //                                 style: const TextStyle(
          //                                     color: Colors.white,
          //                                     fontSize: 25,
          //                                     overflow: TextOverflow.ellipsis,
          //                                     fontWeight: FontWeight.bold),
          //                               ),
          //                               Text(
          //                                 '${blog.user.userAccount.firstName!} ${blog.user.userAccount.lastName!}',
          //                                 style: const TextStyle(
          //                                   color: Colors.white,
          //                                   fontSize: 15,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         IconButton(
          //                             onPressed: () {},
          //                             icon: const Icon(
          //                               IconlyLight.bookmark,
          //                               color: Colors.white,
          //                             ))
          //                       ],
          //                     ),
          //                     const Spacer(),
          //                     Text(
          //                         state
          //                             .blogs
          //                             .latest_updated_posts_model![index]
          //                             .title!,
          //                         maxLines: 2,
          //                         overflow: TextOverflow.ellipsis,
          //                         style: const TextStyle(
          //                             color: Colors.white,
          //                             fontSize: 27,
          //                             height: 1.5)),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
          // ,
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesInitial) {
                context.read<CategoriesBloc>().add(LoadCategoriesData());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoriesLoaded) {
                return DefaultTabController(
                  length: state.categories!.length + 1,
                  child: TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true, // Required
                      onTap: (v) {
                        if (v == 0) {
                          category = null;
                          context
                              .read<ArticalesCubitCubit>()
                              .loadArticles(following: following);
                        } else {
                          context.read<ArticalesCubitCubit>().loadArticles(
                              following: following,
                              category: state.categories![v - 1].name!);
                        }
                      },
                      unselectedLabelColor:
                          primaryColor.withOpacity(0.5), // Other tabs color
                      // labelPadding:
                      //     EdgeInsets.symmetric(horizontal: 30), // Space between tabs
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                            color: primaryColor, width: 2), // Indicator height
                        insets: EdgeInsets.symmetric(
                            horizontal: 0), // Indicator width
                      ),
                      tabs: [
                        const Tab(
                          child: Text(
                            'All',
                            style: TextStyle(
                                color: primaryColor,
                                // fontSize: 20,
                                // fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...state.categories!.map((e) => Tab(
                              child: Text(
                                e.name!,
                                style: const TextStyle(
                                    color: primaryColor,
                                    // fontSize: 20,
                                    // fontSize: 19,
                                    fontWeight: FontWeight.normal),
                              ),
                            ))
                      ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          BlocBuilder<ArticalesCubitCubit, ArticalesCubitState>(
              builder: (context, state) {
            if (state is ArticalesCubitInitial) {
              context.read<ArticalesCubitCubit>().loadArticles();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ArticalesLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlogPostsList(
                  // blogs: state.pageModel.results,
                  posts: state.pageModel.results,
                ),
              );
            } else if (state is ArticalesCubitInitial ||
                state is ArticalesLoading) {
              return const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            }
            return Text(state.toString());
          }),
        ],
      ),
    );
    // }
  }
}

class BlogPostsList extends StatelessWidget {
  List<ArticlesModel>? posts;
  // List<BlogModel>? blogs;

  BlogPostsList({
    super.key,
    // required this.blogs,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return posts!.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: posts!.length,
            itemBuilder: (BuildContext context, int index) {
              // BlogModel blog = getBlogFromId(posts![index].blog!, blogs!);
              return ArticaleWidget(
                articlesModel: posts![index],
              );

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, BlogPostScreen.routeName,
                      arguments: posts![index]);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: NetworkImage(posts![index].cover!),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitHeight,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.darken),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, BlogScreen.routeName,
                                //     arguments: art);
                              },
                              child: Text(
                                posts![index].blog!.title!,
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              posts![index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //to profile
                                // Navigator
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 12,
                                    backgroundImage:
                                        posts![index].blog!.cover != null
                                            ? NetworkImage(
                                                ApiEndpoints.baseUrl +
                                                    posts![index]
                                                        .blog!
                                                        .cover!
                                                        .replaceFirst('/', ""))
                                            : const AssetImage(
                                                    'assets/images/drimage.png')
                                                as ImageProvider,
                                  ),
                                  Text(
                                    '${posts![index].blog!.user!.userAccount.firstName} ${posts![index].blog!.user!.userAccount.lastName!}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                       Icon(
                                        IconlyLight.time_circle,
                                        size: 12,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        LocalStorage.timeAgo(
                                          DateTime.parse(
                                            posts![index].createdAt!.toString(),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Icon(
                  IconlyLight.bookmark,
                  size: 50,
                  color: Colors.grey,
                ),
                Text('No Posts'),
              ],
            ),
          );
  }
}

getBlogFromId(int id, List<BlogModel> blogs) {
  return blogs.firstWhere((element) => element.id == id);
}
