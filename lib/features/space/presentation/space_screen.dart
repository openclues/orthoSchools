import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/bloc/space_bloc.dart';
import 'package:azsoon/features/space/data/space_model.dart';
import 'package:azsoon/features/space/presentation/add_post.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';

import '../../home_screen/presentation/widgets/post_widget.dart';
import '../bloc/add_post_bloc.dart';
import '../bloc/bloc/load_space_oists_bloc.dart';
import '../bloc/my_spaces_bloc.dart';

class SpaceScreen extends StatefulWidget {
  static const String routeName = "/space";
  final int id;

  const SpaceScreen({super.key, required this.id});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SpaceBloc>().add(LoadSpace(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceBloc, SpaceState>(
      builder: (context, state) {
        if (state is SpaceInitial || state is SpaceLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        } else if (state is SpaceLoaded) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    //show top sheet
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          // height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Space Info',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(state.space.description!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Categories",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Wrap(
                                  children: state.space.category!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(
                                              label: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.network(e.image!),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    e.name!,
                                                    style: const TextStyle(
                                                        color: primaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    IconlyBroken.info_circle,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconlyLight.search,
                      color: primaryColor,
                    )),
              ],
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                state.space.name!,
                style: const TextStyle(color: primaryColor),
              ),
            ),
            body: ListView(
              children: [
                //cover image
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.space.cover!),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Image.network(state.space.cover!),
                ),
                //space name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              state.space.name!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            // context
                            //     .read<SpaceBloc>()
                            //     .add(LeaveSpace(id: state.space.id!));
                          },
                          child: const Text(
                            'Leave Space',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )),
                    ],
                  ),
                ),
                //add Post

                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context)
                        .push(PageAnimationTransition(
                            pageAnimationType: BottomToTopTransition(),
                            page: MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => MySpacesBloc(),
                                ),
                                BlocProvider(
                                  create: (context) => AddPostBloc(),
                                ),
                              ],
                              child: AddPostScreen(
                                space: state.space,
                              ),
                            )))
                        .then((value) {
                      context.read<SpaceBloc>().add(LoadSpace(id: widget.id));
                    });
                    //show modal bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/drimage.png"),
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
                              padding: EdgeInsets.all(8.0),
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
                ),
                //posts

                BlocProvider(
                  create: (context) => LoadSpaceOistsBloc(),
                  child: SpacePostsList(
                    spaceId: state.space.id,
                  ),
                ),
                //load space posts.
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
          );
        } else {
          return Center(child: Text(state.toString() + 'error occured'));
        }
      },
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<LoadSpaceOistsBloc>().state is LoadSpaceOistsInitial) {
      context
          .read<LoadSpaceOistsBloc>()
          .add(LoadSpaceOists(widget.spaceId, null));
    }
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 200,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sort By',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Most Recent',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Most Popular',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
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
          BlocBuilder<LoadSpaceOistsBloc, LoadSpaceOistsState>(
            builder: (context, state) {
              if (state is LoadSpaceOistsInitial) {
                return Center(
                  child: Text(state.toString()),
                );
              }
              if (state is LoadSpacePostsLoading) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.toString()),
                      const CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ],
                  ),
                );
              } else if (state is LoadSpaceLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(state.posts[index].title!);
                  },
                );
              } else {
                return Center(
                  child: Text(state.toString()),
                );
              }
            },
          ),
        ]);
  }
}
