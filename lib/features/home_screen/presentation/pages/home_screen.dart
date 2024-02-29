import 'package:animate_do/animate_do.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/Auth/presentaiton/screens/SignIn.dart';
import 'package:azsoon/features/blog/presentation/screens/articles_feed.dart';
import 'package:azsoon/features/home_screen/presentation/pages/spaces_feed_screen.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesWidget.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/premiem_zone/presentation/prem_screen.dart';
import 'package:azsoon/features/space/presentation/add_post.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:azsoon/common_widgets/Post.dart';
import 'package:azsoon/common_widgets/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../../../blog/bloc/articles_feed_bloc.dart';
import '../../../profile/bloc/profile_bloc.dart';
import '../../../space/bloc/add_post_bloc.dart';
import '../../../space/bloc/cubit/verify_email_cubit.dart';
import '../../../space/join_space/bloc/join_space_bloc.dart';
import '../../bloc/home_screen_bloc.dart';
import '../discover_screen.dart';
import '../widgets/add_space_post_blog_article_button.dart';
import '../widgets/app-bar.dart';
import '../widgets/navigation_item_widget.dart';

class HomeScreenPage extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  // void didChangeDependencies() {
  // context.read<HomeScreenBloc>().add(const LoadHomeScreenData());
  //   super.didChangeDependencies();
  // }
  void initState() {
    context.read<HomeScreenBloc>().add(const LoadHomeScreenData());

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
      },
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenInitial) {
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
            return const Scaffold(
              body: Center(
                  child: Text(
                'Your session has expired',
                style: TextStyle(color: Colors.red),
              )),
            );
          } else {
            return const HomeScreenLoadedScreen();
          }
        },
      ),
    );
  }
}

class HomeScreenLoadedScreen extends StatefulWidget {
  const HomeScreenLoadedScreen({super.key});

  @override
  State<HomeScreenLoadedScreen> createState() => _HomeScreenLoadedScreenState();
}

List<Widget> _widgetOptions = <Widget>[
  const SpacesFeedScreen(),
  BlocProvider(
    create: (context) => ArticlesFeedBloc(),
    child: const ArticlesFeedScreen(),
  ),
  const Scaffold(body: DiscoverScreen()),
  BlocProvider(
    create: (context) => VerifyEmailCubit(),
    child: const SettingsScreen(),
  ),
  const PremiumZone(),
];

class _HomeScreenLoadedScreenState extends State<HomeScreenLoadedScreen> {
  bool isVisible = true;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state is AddPostLoaded) {
            // Navigator.pushReplacementNamed(context, SpaceScreen.routeName,
            //     arguments: state.);

            context.read<HomeScreenBloc>().add(const LoadHomeScreenData());

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
            backgroundColor: bodyColor,
            floatingActionButton: const AddSpacePostBlogButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, right: 8, left: 8, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //create 4 buttons

                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          child: BottomNavigationItem(
                              activeWidget: const Icon(
                                IconlyBold.home,
                                color: primaryColor,
                              ),
                              inactiveWidget: Icon(IconlyLight.home,
                                  color: Colors.grey[400]),
                              isSelected: _currentIndex == 0)),

                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                          child: BottomNavigationItem(
                              activeWidget: const Icon(
                                FontAwesomeIcons.newspaper,
                                color: primaryColor,
                              ),
                              inactiveWidget: Icon(FontAwesomeIcons.newspaper,
                                  color: Colors.grey[400]),
                              isSelected: _currentIndex == 1)),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                          },
                          child: BottomNavigationItem(
                              activeWidget: const Icon(
                                IconlyBold.category,
                                color: primaryColor,
                              ),
                              inactiveWidget: Icon(IconlyLight.category,
                                  color: Colors.grey[400]),
                              isSelected: _currentIndex == 2)),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 3;
                            });
                          },
                          child: Stack(
                            children: [
                              BottomNavigationItem(
                                  activeWidget: const Icon(IconlyBold.setting,
                                      color: primaryColor, size: 30),
                                  inactiveWidget: Icon(
                                    IconlyLight.setting,
                                    color: Colors.grey[400],
                                    size: 30,
                                  ),
                                  isSelected: _currentIndex == 3),
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  if (state is ProfileLoaded &&
                                      state.profileModel.user!.isVerified ==
                                          false &&
                                      state.profileModel.user!.isVerifiedPro ==
                                          false &&
                                      state.profileModel.user!.userRole == 1) {
                                    return Positioned(
                                        top: 0,
                                        right: 0,
                                        child: HeartBeatAnimation());
                                  }
                                  return const SizedBox();
                                },
                              )
                            ],
                          )),

                      Visibility(
                        visible: context.read<ProfileBloc>().state
                                    is ProfileLoaded &&
                                (context.read<ProfileBloc>().state
                                            as ProfileLoaded)
                                        .profileModel
                                        .user!
                                        .userRole ==
                                    2
                            ? true
                            : false,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentIndex = 4;
                              });
                            },
                            child: BottomNavigationItem(
                                activeWidget: Image.asset(
                                  'assets/images/verified-account.png',
                                  height: 30,
                                ),
                                inactiveWidget: Image.asset(
                                    'assets/images/verified-account.png',
                                    height: 30,
                                    color: Colors.grey[400]),
                                isSelected: _currentIndex == 4)),
                      ),

                      // Column(
                    ],
                  ),
                ),
              ),
            ),

            //     }),
            appBar: buildAppBar(context),
            body: _widgetOptions[_currentIndex]));
  }
}

class HeartBeatAnimation extends StatefulWidget {
  @override
  _HeartBeatAnimationState createState() => _HeartBeatAnimationState();
}

class _HeartBeatAnimationState extends State<HeartBeatAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Adjust duration as needed
      reverseDuration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation!.value,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
