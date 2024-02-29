import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/become_premium/presentation/be_premium_screen.dart';
import '../features/home_screen/bloc/home_screen_bloc.dart';
import '../features/home_screen/presentation/widgets/post_widget.dart';
import '../features/space/join_space/bloc/join_space_bloc.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // print('post widget');
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Text(
                  'Spaces feed',
                  style: TextStyle(
                    fontSize: 15,
                    color: primaryColor,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.posts.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      // context.read<PostsBloc>().add(LoadPosts());
                      // context.read<PostsBloc>()
                      // }
                      return SpacePostWidget(
                        isHomeScreen: true,
                        post: state.posts.results[index],
                      );
                    },
                  ),
                  // if (state.isLoading == true)
                  //   const Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Center(
                  //       child: CircularProgressIndicator(
                  //         color: primaryColor,
                  //       ),
                  //     ),
                  //   )
                ],
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
        // } else {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
      },
    );
  }
}

class JoinButton extends StatelessWidget {
  // final RecommendedSpace space;
  final bool isJoined;
  final bool isAllowedToJoin;
  final int spaceId;
  final Color? color;
  const JoinButton({
    required this.isAllowedToJoin,
    required this.spaceId,
    required this.isJoined,
    this.color,
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
                //SHOW FLOTING DIALOG

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Column(
                            children: [
                              Row(
                                children: [
                                  // Icon(
                                  //   Icons.warning,
                                  //   color: Colors.red,
                                  // ),
                                  Expanded(
                                    child: Text(
                                      'You are not allowed to join this space',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("You have to be a premium user to join",
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                          actions: [
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        primaryColor)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const PartnerForm();
                                  }));
                                },
                                child: const Text('Become a premium user',
                                    style: TextStyle(color: Colors.white))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                          ],
                        ));
              }
            },
            child: BlocBuilder<JoinSpaceBloc, JoinSpaceState>(
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: state is JoinSpaceLoading && state.spaceId == spaceId
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: color ?? primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Join',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                );
              },
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
          // width: LocalStorage.getcreenSize(context).width,
          width: double.infinity,
          height: 100,
          child: Image.network(
            post.postImages![0].image!,
            fit: BoxFit.fitWidth,
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
      } else {
        return Container();
      }

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
      child: ClipRect(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.network(
            image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
