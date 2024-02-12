import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/categories/bloc/categories_bloc.dart';
import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';
import 'package:azsoon/features/home_screen/presentation/pages/category_screen.dart';
import 'package:azsoon/common_widgets/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import '../../blog/data/models/articles_model.dart';
import '../../space/presentation/space_screen.dart';
import 'widgets/spacesWidget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  CategoryModel? selectedCategory;
  String? selectedImage;
  String? categoryId;
  bool showOtherCategories = true;
  bool? isLoading = false;
  List<BlogModel> blogs = [];
  List<RecommendedSpace> spaces = [];
  bool? screenLoading = true;
  @override
  void initState() {
    // getPopularSpaces();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // await getPopularSpaces();
    // setState(() {});
  }

  Future<Response> getPopularSpaces() async {
    return await RequestHelper.get('discover/screen');
  }
// CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        body: ListView(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesInitial) {
                  BlocProvider.of<CategoriesBloc>(context)
                      .add(LoadCategoriesData());
                }
                if (state is CategoriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoriesLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                        // width: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.categories!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                   
                                    if (selectedCategory ==
                                        state.categories![index]) {
                                      setState(() {
                                        selectedCategory = null;
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory =
                                            state.categories![index];
                                      });
                                    }
                                    // setState(() {
                                    //   selectedCategory = state.categories![index];
                                    // });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: selectedCategory ==
                                                    state.categories![index]
                                                ? primaryColor
                                                : primaryColor.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              state.categories![index].name!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: selectedCategory ==
                                                        state.categories![index]
                                                    ? Colors.white
                                                    : primaryColor,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -20,
                                  right: 0,
                                  child: Visibility(
                                    visible: selectedCategory != null &&
                                        selectedCategory ==
                                            state.categories![index],
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: primaryColor),
                                      onPressed: () {
                                        setState(() {
                                          selectedCategory = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      if (selectedCategory == null)
                        FutureBuilder(
                            future: getPopularSpaces(),
                            builder: (
                              context,
                              AsyncSnapshot<Response> snapshot,
                            ) {
                              if (snapshot.hasData) {
                                var decodedResponse = jsonDecode(
                                    utf8.decode(snapshot.data!.bodyBytes));
                                blogs = [];
                                spaces = [];
                                // spaces = decodedResponse['spaces'];
                                for (var space in decodedResponse['spaces']) {
                                  spaces.add(RecommendedSpace.fromJson(space));
                                }
                                for (var blog in decodedResponse['blogs']) {
                                  blogs.add(BlogModel.fromJson(blog));
                                }
                                return ExploreMenuContent(
                                    spaces: spaces, blogs: blogs);
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 300.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            }),
                      if (selectedCategory != null)
                        FutureBuilder(
                            future: _animateToSelectedCategory(
                              selectedCategory!.id!.toString(),
                              selectedCategory!.id!.toString(),
                            ),
                            builder: (context, AsyncSnapshot snapshot) =>
                                ExploreMenuContent(
                                    spaces: spaces,
                                    blogs: blogs,
                                    selectedCategory: selectedCategory!.name)),
                    ],
                  );
                } else {
                  //return shimmer efffect
                  return Container();
                }
              },
            ),
          ],
        )

        //  ListView(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: AnimatedContainer(
        //         duration: const Duration(milliseconds: 500),
        //         // padding: const EdgeInsets.all(16.0),
        //         decoration: BoxDecoration(
        //           color: primaryColor,
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             IconButton(
        //               onPressed: () {
        //                 if (selectedCategory == null) {
        //                 } else {
        //                   setState(() {
        //                     showOtherCategories = !showOtherCategories;
        //                   });
        //                 }
        //               },
        //               icon: Icon(
        //                 showOtherCategories
        //                     ? Icons.keyboard_arrow_up
        //                     : Icons.keyboard_arrow_down,
        //                 color: Colors.white,
        //               ),
        //             ),
        //             Row(
        //               children: [
        //                 selectedImage != null
        //                     ? Image.network(
        //                         selectedImage!,
        //                         height: 50,
        //                         width: 50,
        //                       )
        //                     : const SizedBox(),
        //                 Text(
        //                   selectedCategory == null || selectedCategory!.isEmpty
        //                       ? 'All'
        //                       : selectedCategory!,
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 18,
        //                     // fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Container(),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Visibility(
        //       visible: showOtherCategories,
        //       child: GridView.builder(
        //         physics: const NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           crossAxisSpacing: 0,
        //           mainAxisSpacing: 16,
        //         ),
        //         itemCount: context.read<CategoriesBloc>().state
        //                 is CategoriesLoaded
        //             ? (context.read<CategoriesBloc>().state as CategoriesLoaded)
        //                 .categories!
        //                 .length
        //             : 0,
        //         itemBuilder: (context, index) {
        //           CategoriesLoaded st =
        //               context.read<CategoriesBloc>().state as CategoriesLoaded;
        //           return GestureDetector(
        //             onTap: () {
        //               _animateToSelectedCategory(
        //                   st.categories![index].name!,
        //                   st.categories![index].image,
        //                   st.categories![index].id.toString());
        //             },
        //             child: Container(
        //               margin: const EdgeInsets.all(16),
        //               decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                   image: NetworkImage(
        //                     st.categories![index].image!,
        //                   ),
        //                   fit: BoxFit.cover,
        //                   colorFilter: ColorFilter.mode(
        //                     Colors.black.withOpacity(0.6),
        //                     BlendMode.darken,
        //                   ),
        //                 ),
        //                 color: primaryColor,
        //                 borderRadius: BorderRadius.circular(12),
        //               ),
        //               child: Builder(builder: (context) {
        //                 return Align(
        //                   alignment: Alignment.bottomCenter,
        //                   child: Text(
        //                     st.categories![index].name!,
        //                     textAlign: TextAlign.center,
        //                     style: const TextStyle(
        //                       color: Colors.white,
        //                       // fontWeight: FontWeight.bold,
        //                       fontSize: 18,
        //                     ),
        //                   ),
        //                 );
        //               }),
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //     if (selectedCategory != null &&
        //         selectedCategory!.isNotEmpty &&
        //         showOtherCategories == false)
        //       DefaultTabController(
        //         length: 2,
        //         animationDuration: Duration.zero,
        //         child: SizedBox(
        //           child: Column(
        //             children: [
        //               const TabBar(
        //                 tabs: [
        //                   Tab(text: 'Blogs'),
        //                   Tab(text: 'Spaces'),
        //                   // Tab(text: 'Articles'),
        //                 ],
        //               ),
        //               Container(
        //                 height: MediaQuery.of(context).size.height * 0.5,
        //                 child: TabBarView(
        //                   physics: const BouncingScrollPhysics(),
        //                   children: [
        //                     // Content for 'Blogs' tab

        //                     isLoading!
        //                         ? const Center(
        //                             child: CircularProgressIndicator(),
        //                           )
        //                         : ListView.builder(
        //                             physics: const NeverScrollableScrollPhysics(),
        //                             itemCount: blogs.length,
        //                             itemBuilder:
        //                                 (BuildContext context, int index) {
        //                               return GestureDetector(
        //                                 onTap: () {
        //                                   Navigator.pushNamed(
        //                                       context, BlogScreen.routeName,
        //                                       arguments: BlogsModel(
        //                                         cover: blogs[index].cover,
        //                                         title: blogs[index].title,
        //                                         description:
        //                                             blogs[index].description,
        //                                         id: blogs[index].id,
        //                                         user: blogs[index].user,
        //                                       ));
        //                                 },
        //                                 child: Container(
        //                                   height: 100,
        //                                   margin: const EdgeInsets.all(16),
        //                                   decoration: BoxDecoration(
        //                                     image: DecorationImage(
        //                                       image: NetworkImage(
        //                                         blogs[index].cover!,
        //                                       ),
        //                                       fit: BoxFit.cover,
        //                                       colorFilter: ColorFilter.mode(
        //                                         Colors.black.withOpacity(0.6),
        //                                         BlendMode.darken,
        //                                       ),
        //                                     ),
        //                                     color: primaryColor,
        //                                     borderRadius:
        //                                         BorderRadius.circular(12),
        //                                   ),
        //                                   child: Builder(builder: (context) {
        //                                     return Column(
        //                                       crossAxisAlignment:
        //                                           CrossAxisAlignment.stretch,
        //                                       children: [
        //                                         Padding(
        //                                           padding:
        //                                               const EdgeInsets.all(8.0),
        //                                           child: Text(
        //                                             blogs[index].title!,
        //                                             textAlign: TextAlign.center,
        //                                             style: const TextStyle(
        //                                               color: Colors.white,
        //                                               // fontWeight: FontWeight.bold,
        //                                               fontSize: 18,
        //                                             ),
        //                                           ),
        //                                         ),
        //                                         const Spacer(),
        //                                         Padding(
        //                                           padding:
        //                                               const EdgeInsets.all(10.0),
        //                                           child: Row(
        //                                             // crossAxisAlignment:
        //                                             //     CrossAxisAlignment
        //                                             //         .end,
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceBetween,

        //                                             mainAxisSize:
        //                                                 MainAxisSize.max,
        //                                             children: [
        //                                               Row(
        //                                                 // mainAxisAlignment:
        //                                                 //     MainAxisAlignment
        //                                                 //         .spaceEvenly,
        //                                                 crossAxisAlignment:
        //                                                     CrossAxisAlignment
        //                                                         .end,
        //                                                 children: [
        //                                                   const Text(
        //                                                       "Followers: ",
        //                                                       style: TextStyle(
        //                                                           color: Colors
        //                                                               .white)),
        //                                                   Text(
        //                                                     blogs[index]
        //                                                         .followersCount
        //                                                         .toString(),
        //                                                     style:
        //                                                         const TextStyle(
        //                                                             color: Colors
        //                                                                 .white),
        //                                                   ),

        //                                                   const SizedBox(
        //                                                     width: 10,
        //                                                   ),
        //                                                   // Spacer(),
        //                                                   Row(
        //                                                     // mainAxisAlignment:
        //                                                     //     MainAxisAlignment
        //                                                     //         .spaceEvenly,
        //                                                     children: [
        //                                                       const Text(
        //                                                           "Articles: ",
        //                                                           style: TextStyle(
        //                                                               color: Colors
        //                                                                   .white)),
        //                                                       Text(
        //                                                         blogs[index]
        //                                                             .articlesCount
        //                                                             .toString(),
        //                                                         style: const TextStyle(
        //                                                             color: Colors
        //                                                                 .white),
        //                                                       )
        //                                                     ],
        //                                                   ),
        //                                                   // Container(
        //                                                   //   child: blogs[index].,
        //                                                   // )
        //                                                 ],
        //                                               )
        //                                             ],
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     );
        //                                   }),
        //                                 ),
        //                               );
        //                               // return (
        //                               // );
        //                             },
        //                           ),

        //                     // Content for 'Articles' tab

        //                     isLoading!
        //                         ? const Center(
        //                             child: CircularProgressIndicator(),
        //                           )
        //                         : ListView.builder(
        //                             physics: const NeverScrollableScrollPhysics(),
        //                             itemCount: spaces.length,
        //                             itemBuilder:
        //                                 (BuildContext context, int index) {
        //                               return Text(spaces[index].name!);
        //                             },
        //                           ),
        //                     // Center(
        //                     //   child: Text('Articles Content'),
        //                     // ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //   ],
        // ),

        );
  }

  _animateToSelectedCategory(String? image, String? cateogryId) async {
    // setState(() {
    //   // selectedCategory! = category;

    //   selectedImage = image;
    //   showOtherCategories = false;
    // });
    // setState(() {
    //   isLoading = true;
    // });
    var response = await RequestHelper.get('filter/?category_id=$cateogryId');
    if (response.statusCode == 200) {
      spaces = [];
      blogs = [];
      // spaces = jsonDecode(utf8.decode(response.bodyBytes)['blogs'].map((blog) {
      //   return BlogModel.fromJson(blog);
      // }).toList() as List<RecommendedSpace>;
      for (var blog in jsonDecode(utf8.decode(response.bodyBytes))['blogs']) {
        blogs.add(BlogModel.fromJson(blog));
      }
      blogs.shuffle();
      //get just 5
      // blogs = blogs.sublist(0, 5);
      for (var space in jsonDecode(utf8.decode(response.bodyBytes))['spaces']) {
        spaces.add(RecommendedSpace.fromJson(space));
      }
      spaces.shuffle();
      //get just 5
      // spaces = spaces.sublist(0, 5);
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      // setState(() {
      //   isLoading = false;
      // });
    }
  }
}

class BlogDiscoveryItem extends StatelessWidget {
  final BlogModel blog;
  const BlogDiscoveryItem({Key? key, required this.blog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BlogScreen.routeName,
            arguments: BlogsModel(
              cover: blog.cover,
              title: blog.title,
              description: blog.description,
              id: blog.id,
              user: blog.user,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width / 1.2,
          // height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(
                blog.cover!,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ),
            ),
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       const Icon(FontAwesomeIcons.userGroup,
                //           color: Colors.white, size: 18),
                //       const SizedBox(
                //         width: 5,
                //       ),
                //       Text(blog.followersCount.toString(),
                //           style:
                //               const TextStyle(color: Colors.white, fontSize: 18)),
                //       const Spacer(),
                //       TextButton(
                //         onPressed: () {},
                //         child: const Text(
                //           "Follow",
                //           style: TextStyle(
                //             shadows: [
                //               Shadow(
                //                 color: primaryColor,
                //                 blurRadius: 10,
                //                 offset: Offset(0, 0),
                //               ),
                //             ],
                //             color: Color(
                //               0xFFFFFFFF,
                //             ),
                //             fontSize: 19,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Follow",
                          style: TextStyle(color: primaryColor),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        "${blog.followersCount} Followers",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreMenuContent extends StatefulWidget {
  final String? selectedCategory;
  final List<RecommendedSpace> spaces;
  final List<BlogModel> blogs;

  const ExploreMenuContent(
      {super.key,
      required this.spaces,
      required this.blogs,
      this.selectedCategory});

  @override
  State<ExploreMenuContent> createState() => _ExploreMenuContentState();
}

class _ExploreMenuContentState extends State<ExploreMenuContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.selectedCategory == null
                ? "popular blogs"
                : "blogs in ${widget.selectedCategory}",
            style: const TextStyle(fontSize: 20, color: primaryColor),
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.blogs.length,
            itemBuilder: (BuildContext context, int index) {
              BlogModel blog = widget.blogs[index];
              return BlogDiscoveryItem(blog: blog);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.selectedCategory == null
                ? "popular spaces"
                : "spaces in ${widget.selectedCategory}",
            style: const TextStyle(fontSize: 20, color: primaryColor),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          // height: 180,
          // height: MediaQuery.of(context).size.height / 2.5,
          // width: 150,
          decoration: const BoxDecoration(
              // color: primaryColor,
              // borderRadius: BorderRadius.circular(12),
              ),
          child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            // scrollDirection: Axis.vertical,

            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.spaces.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 200,
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.spaces[index].cover!,
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.darken,
                    ),
                  ),
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.spaces[index].name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.spaces[index].description!,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SpaceScreen.routeName,
                                    arguments: widget.spaces[index]);
                              },
                              child: const Text(
                                "Join Now",
                                style: TextStyle(color: primaryColor),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          // const Spacer(),
                          Expanded(
                            child: Text(
                              "${widget.spaces[index].membersCount} Participants",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
