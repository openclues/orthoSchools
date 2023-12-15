import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/blog/bloc/blogs_bloc.dart';
import 'package:azsoon/features/blog/presentation/screens/blogWriting.dart';
import 'package:azsoon/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/features/join_space/bloc/join_space_bloc.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/presentation/screens/profile_screen.dart';
import 'package:azsoon/features/space/presentation/add_post.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:tab_container/tab_container.dart';
import '../../../../Auth/presentaiton/screens/SignIn.dart';
import '../../../../widgets/Navigation-Drawer.dart' as appdrawer;
import '../../../blog/data/models/blog_model.dart';
import '../../../blog/presentation/screens/blog_post_screen.dart';
import '../../../space/bloc/add_post_bloc.dart';
import '../../../space/bloc/my_spaces_bloc.dart';

class HomeScreenPage extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

int _currentIndex = 0;

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  void initState() {
    context.read<HomeScreenBloc>().add(const LoadHomeScreenData());
    print('initState');
    super.initState();
  }

  @override
  void dispose() {
    context.read<HomeScreenBloc>().add(const ReasetHomeScreenData());
    print('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    context.read<HomeScreenBloc>().add(const ReasetHomeScreenData());
    print('deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) async {
        if (state is HomeScreenNotAuthenticated) {
          await LocalStorage.removeAll().then((value) {
            if (context.mounted) {
              Navigator.of(context).pushNamed(SignInScreen.routeName);
            }
          });
        }
        // TODO: implement listener
      },
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenInitial) {
            // BlocProvider.of<HomeScreenBloc>(context).add(
            //   const LoadHomeScreenData(),
            // );
            return const LoadingWidget();
          } else if (state is HomeScreenLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeScreenError) {
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          } else if (state is HomeScreenNotAuthenticated) {
            return const Center(
              child: Text('Your session has expired'),
            );
          } else {
            return const HomeScreenLoadedScreen();
          }
        },
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    bottom: PreferredSize(
        preferredSize: const Size(30, 50),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.pinkAccent[50],
                borderRadius: BorderRadius.circular(10),
              ),
              // ignore: prefer_const_constructors
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Your  account is not verified yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        )),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 47, 47, 47)),
    elevation: 0,
    centerTitle: true,
    leading: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        //
        Expanded(
          child: Image.asset(
            'assets/images/drimage.png',
            height: 100,
          ),
        )
      ],
    ),
    backgroundColor: Colors.white,
    actions: [
      IconButton(
          onPressed: () async {
            await LocalStorage.removeAuthToken().then((_) {
              if (context.mounted) {
                Navigator.of(context)
                    .pushReplacementNamed(LoadingScreen.routeName);
              }
            });
          },
          icon: const Icon(Icons.logout)),
      // IconButton(
      //     onPressed: () async {
      //       Navigator.of(context).pushNamed(BlogWritingScreen.routeName);
      //     },
      //     icon: Icon(Icons.folder)),
      IconButton(onPressed: () {}, icon: const Icon(IconlyLight.search)),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              IconlyLight.notification,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '+10',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    ],
    title: Image.asset(
      'assets/images/logo.png',
      height: 40,
    ),
  );
}

class HomeScreenLoadedScreen extends StatefulWidget {
  const HomeScreenLoadedScreen({super.key});

  @override
  State<HomeScreenLoadedScreen> createState() => _HomeScreenLoadedScreenState();
}

List<Widget> _widgetOptions = <Widget>[
  const HomeScreenTab(),
  const Scaffold(
    body: Center(
      child: Text('Profile'),
    ),
  ),
  BlocProvider(
    create: (context) => ProfileBloc(),
    child: const ProfileScreen(),
  ),
  const Scaffold(
    body: Center(
      child: Text('Settings'),
    ),
  )
];

class _HomeScreenLoadedScreenState extends State<HomeScreenLoadedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<JoinSpaceBloc, JoinSpaceState>(
      listener: (context, state) {
        if (state is JoinSpaceSuccess) {
          Navigator.pushNamed(context, SpaceScreen.routeName,
              arguments: state.spaceId);
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            // backgroundColor: const Color.fromARGB(255, 242, 242, 242),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.white,
              backgroundColor: primaryColor,
              onPressed: () async {
                //show bottom to choose between posting in space or in a blog
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create Post',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              onTap: () async {
                                await Navigator.of(context).push(
                                    PageAnimationTransition(
                                        pageAnimationType:
                                            BottomToTopTransition(),
                                        page: MultiBlocProvider(
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
                                          child: const AddPostScreen(),
                                        )));
                              },
                              leading: const Icon(
                                IconlyLight.home,
                                color: primaryColor,
                              ),
                              title: const Text('In a Space'),
                              subtitle: const Text(
                                  'Post in a space you are a member of'),
                            ),
                            Builder(builder: (context) {
                              return ListTile(
                                onTap: () {
                                  //show another modal to tell user that he is not verified yet so he can not post on a blog. and ask him verify his account first

                                  showBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              const Text(
                                                  'You are not verified yet'),
                                              const Text(
                                                  'Please verify your account first'),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: const Text('Verify'))
                                            ],
                                          ),
                                        );
                                      });

                                  // Navigator.pop(context);
                                  // Navigator.pushNamed(
                                  //     context, SpaceScreen.routeName,
                                  //     arguments: 2);
                                },
                                leading: const Icon(
                                  IconlyLight.home,
                                  color: primaryColor,
                                ),
                                title: const Text('In a Blog'),
                                subtitle: const Text('Post in your blog'),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                IconlyBold.plus,
                // opticalSize: 1.5,
                semanticLabel: 'Add',
                size: 30,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              backgroundColor: primaryColor,
              inactiveColor: Colors.grey[400],
              activeColor: Colors.white,
              blurEffect: true,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 20,
              safeAreaValues: const SafeAreaValues(top: true),
              // scaleFactor: double.maxFinite,
              // splashRadius: 32,
              elevation: 20,
              rightCornerRadius: 20,
              icons: [
                _currentIndex == 0 ? IconlyBold.home : IconlyLight.home,
                _currentIndex == 1 ? IconlyBold.category : IconlyLight.category,
                _currentIndex == 2 ? IconlyBold.profile : IconlyLight.profile,
                _currentIndex == 3 ? IconlyBold.setting : IconlyLight.setting,
              ],
              activeIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            appBar: buildAppBar(context),
            drawer: appdrawer.NavigationDrawer(),
            body: _widgetOptions[_currentIndex]),
      ),
    );
  }
}

class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabContainer(
        childPadding: const EdgeInsets.all(0),
        childDuration: const Duration(milliseconds: 0),
        tabCurve: Curves.easeIn,
        tabExtent: 35,
        tabEdge: TabEdge.left,
        colors: [
          Colors.grey[200]!,
          Colors.grey[200]!,
        ],
        tabs: const [
          RotatedBox(
            quarterTurns: 3,
            child: Padding(
              padding: EdgeInsets.all(.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Spaces',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    IconlyLight.activity,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Blogs',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    IconlyLight.document,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
        childCurve: Curves.easeIn,
        isStringTabs: false,
        children: [
          const HomeScreenSpaceTab(),
          BlocProvider(
            create: (context) => BlogsBloc(),
            child: const HomeScreebBlogTab(),
          ),
        ],
      ),
    );
  }
}

class HomeScreenSpaceTab extends StatelessWidget {
  const HomeScreenSpaceTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: primaryColor,
      color: Colors.white,
      onRefresh: () async {
        context.read<HomeScreenBloc>().add(const LoadHomeScreenData());
      },
      child: BlocListener<JoinSpaceBloc, JoinSpaceState>(
        listener: (context, state) {
          if (state is JoinSpaceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Joined space successfully'),
              ),
            );
          } else if (state is JoinSpaceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        },
        child: ListView(
          children: const [
            SpacesList(),
            PostWidget(),
          ],
        ),
      ),
    );
  }
}

class HomeScreebBlogTab extends StatelessWidget {
  const HomeScreebBlogTab({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<BlogsBloc>().state;
    if (state is BlogsInitial) {
      context.read<BlogsBloc>().add(const LoadBlogs());
    }
    if (state is BlogsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is BlogsLoaded &&
        state.blogs.results != null &&
        state.blogs.results!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latest Articles',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: primaryColor),
                    ))
              ],
            ),
            Container(
              height: LocalStorage.getcreenSize(context).height * 0.3,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.blogs.latest_updated_posts_model!.length,
                itemBuilder: (context, index) {
                  BlogModel blog = getBlogFromId(
                      state.blogs.latest_updated_posts_model![index].blog!,
                      state.blogs.results!);
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, BlogPostScreen.routeName,
                          arguments:
                              state.blogs.latest_updated_posts_model![index]);
                    },
                    child: Hero(
                      tag: state.blogs.latest_updated_posts_model![index].id!,
                      child: Container(
                        width: LocalStorage.getcreenSize(context).width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                          image: DecorationImage(
                            image: NetworkImage(ApiEndpoints.baseUrl +
                                state.blogs.latest_updated_posts_model![index]
                                    .cover!),
                            filterQuality: FilterQuality.high,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.7),
                                BlendMode.darken),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: blog.user.profileImage !=
                                              null
                                          ? NetworkImage(ApiEndpoints.baseUrl +
                                              blog.user.profileImage!)
                                          : const AssetImage(
                                                  'assets/images/drimage.png')
                                              as ImageProvider,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            blog.title!,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${blog.user.userAccount.firstName!} ${blog.user.userAccount.lastName!}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          IconlyLight.bookmark,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                    state
                                        .blogs
                                        .latest_updated_posts_model![index]
                                        .title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        height: 1.5)),
                              ],
                            )),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }
    return ListView(
      children: const [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        )
      ],
    );
  }
}

getBlogFromId(int id, List<BlogModel> blogs) {
  return blogs.firstWhere((element) => element.id == id);
}
