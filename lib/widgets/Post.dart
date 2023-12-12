import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/Providers/userInfoProvider.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';
import 'package:azsoon/features/join_space/bloc/join_space_bloc.dart';
import 'package:azsoon/features/profile/presentation/screens/profile_screen.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../features/home_screen/presentation/bloc/home_screen_bloc.dart';
import '../features/home_screen/presentation/widgets/post_widget.dart';
import 'Navigation-Drawer.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  DateTime time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenLoaded) {
          if (state.homeScreenModel.latestUpdatedPostsFromRecommended != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Text(
                    'Spaces feed',
                    style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.homeScreenModel
                      .latestUpdatedPostsFromRecommended!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpacePostWidget(
                      post: state.homeScreenModel
                          .latestUpdatedPostsFromRecommended![index],
                    );
                  },
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  top: LocalStorage.getcreenSize(context).height * 0.35),
              child: const Center(
                  child: Text(
                'That\'s all for now!',
                style: TextStyle(
                  color: primaryColor,
                ),
              )),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class JoinButton extends StatelessWidget {
  // final RecommendedSpace space;
  final bool isJoined;
  final bool isAllowedToJoin;
  final int spaceId;
  const JoinButton({
    required this.isAllowedToJoin,
    required this.spaceId,
    required this.isJoined,
    // required this.space,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isJoined == false
        ? GestureDetector(
            onTap: () {
              if (isAllowedToJoin) {
                context.read<JoinSpaceBloc>().add(JoinSpace(spaceId: spaceId));
              } else {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            const Text(
                                'You are not allowed to join this space'),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Request to join'))
                          ],
                        ),
                      );
                    });
                // }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: BlocBuilder<JoinSpaceBloc, JoinSpaceState>(
                builder: (context, state) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 5),
                      child:
                          state is JoinSpaceLoading && state.spaceId == spaceId
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                )
                              : const Text("Join ",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)));
                },
              ),
            ),
          )
        : const SizedBox();
  }
}

class PostImagesWidhet extends StatelessWidget {
  final LatestUpdatedPost post;
  const PostImagesWidhet({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.postImages != null && post.postImages!.isNotEmpty) {
      if (post.postImages!.length == 1) {
        return SizedBox(
          width: LocalStorage.getcreenSize(context).width,
          height: 100,
          child: Image.network(
            post.postImages![0].image!,
            fit: BoxFit.fitHeight,
          ),
        );
      } else if (post.postImages!.length == 2) {
        return SizedBox(
          width: LocalStorage.getcreenSize(context).width,
          child: Row(
            children: [
              ImageWidget(
                image: post.postImages![0].image!,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              ImageWidget(
                image: post.postImages![1].image!,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
            ],
          ),
        );
      } else if (post.postImages!.length == 3) {
        return SizedBox(
          height: LocalStorage.getcreenSize(context).height * 0.3,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  width: LocalStorage.getcreenSize(context).width / 2,
                  child: Image.network(
                    post.postImages![0].image!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ImageWidget(
                        image: post.postImages![1].image!,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                        )),
                    ImageWidget(
                        image: post.postImages![2].image!,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ))
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (post.postImages!.length == 4) {
        return SizedBox(
          height: LocalStorage.getcreenSize(context).height * 0.3,
          width: LocalStorage.getcreenSize(context).width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        width: LocalStorage.getcreenSize(context).width / 2,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            post.postImages![0].image!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 1),
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        height: 150,
                        width: LocalStorage.getcreenSize(context).width / 2,
                        child: Image.network(
                          post.postImages![1].image!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: LocalStorage.getcreenSize(context).width / 2,
                        margin: const EdgeInsets.only(left: 1),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Image.network(
                          post.postImages![2].image!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: LocalStorage.getcreenSize(context).width / 2,
                        margin: const EdgeInsets.only(left: 1, top: 1),
                        child: Image.network(
                          post.postImages![3].image!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (post.postImages!.length > 4) {
        return SizedBox(
          height: LocalStorage.getcreenSize(context).height * 0.3,
          width: LocalStorage.getcreenSize(context).width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ImageWidget(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                      image: post.postImages![0].image!,
                    ),
                    ImageWidget(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                      image: post.postImages![1].image!,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ImageWidget(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                      image: post.postImages![2].image!,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: LocalStorage.getcreenSize(context).width / 2,
                            height: 150,
                            // margin: const EdgeInsets.only(left: 1, top: 1),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.white,
                              width: 1,
                            )),

                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                              ),
                              child: Image.network(
                                post.postImages![3].image!,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 150,
                                width:
                                    LocalStorage.getcreenSize(context).width /
                                        2,
                                margin: const EdgeInsets.only(left: 1, top: 1),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                ),
                                child: Center(
                                  child: Text(
                                    '+${post.postImages!.length - 4}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      return SizedBox(
          // height: LocalStorage.getcreenSize(context).height * 0.3,

          child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        // crossAxisSpacing: 4,
        children: const [
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Text('data'),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Text('data'),
          ),
        ],
      )

          //  FlutterCarousel(
          //   options: CarouselOptions(
          //     // height: 400.0,

          //     showIndicator: true,
          //     slideIndicator: const CircularSlideIndicator(
          //         padding: EdgeInsets.only(bottom: 10),
          //         // indicatorBorderWidth: 2,
          //         indicatorRadius: 5,
          //         currentIndicatorColor: primaryColor,
          //         indicatorBackgroundColor: Colors.white,
          //         indicatorBorderColor: Colors.amber),
          //   ),
          //   items: post.postImages!.map((i) {
          //     return Builder(
          //       builder: (BuildContext context) {
          //         return Container(
          //             width: MediaQuery.of(context).size.width,
          //             // margin: const EdgeInsets.symmetric(horizontal: 2),
          //             child: Image.network(
          //               i.image!,
          //               fit: BoxFit.fitWidth,
          //             ));
          //       },
          //     );
          //   }).toList(),
          // ),
          );
    } else {
      return Container();
    }
  }
}

class ImageWidget extends StatelessWidget {
  String? image;
  BorderRadius? borderRadius;
  ImageWidget({super.key, required this.image, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      height: 150,
      width: LocalStorage.getcreenSize(context).width / 2,
      child: Hero(
        tag: image!,
        child: ClipRect(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            child: Image.network(
              image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ));
  }
}
