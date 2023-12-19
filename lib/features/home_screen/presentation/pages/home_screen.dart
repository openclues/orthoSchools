import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/blog/bloc/blogs_bloc.dart';
import 'package:azsoon/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/features/join_space/bloc/join_space_bloc.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/presentation/screens/profile_screen.dart';
import 'package:azsoon/features/space/presentation/add_post.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:azsoon/widgets/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:tab_container/tab_container.dart';
import '../../../../Auth/presentaiton/screens/SignIn.dart';
import '../../../../screens/ProfilePage.dart';
import '../../../../widgets/Navigation-Drawer.dart' as appdrawer;
import '../../../space/bloc/add_post_bloc.dart';
import '../../../space/bloc/my_spaces_bloc.dart';
import 'blogs_home_screen.dart';

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
  bool isVisible = true;

  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size(30, 50),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 8.0,
        ),
        child: Visibility(
          visible: isVisible,
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,

              // borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 0.2,
                ),
              ],
            ),
            child: ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  // setState(() {
                  //   isVisible = false;
                  // });// not working
                },
              ),
              leading: const Icon(
                IconlyLight.danger,
                color: Colors.redAccent,
              ),
              title: const Row(
                children: [
                  Text(
                    'Verify your account !',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
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
      // IconButton(
      //     onPressed: () async {
      //       await LocalStorage.removeAuthToken().then((_) {
      //         if (context.mounted) {
      //           Navigator.of(context)
      //               .pushReplacementNamed(LoadingScreen.routeName);
      //         }
      //       });
      //     },
      //     icon: Icon(Icons.logout)),
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
  MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ProfileBloc(),
      ),
      BlocProvider(
        create: (context) => MySpacesBloc(),
      ),
    ],
    child: const ProfilePage(
      userId: null,
    ),
  ),
  SettingsScreen()
];

class _HomeScreenLoadedScreenState extends State<HomeScreenLoadedScreen> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    print('build');
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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 300,
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
        // childDuration: const Duration(milliseconds: 0),
        // tabCurve: Curves.easeIn,
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
