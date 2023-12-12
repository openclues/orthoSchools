import 'package:azsoon/Auth/screens/SignIn.dart';
import 'package:azsoon/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:azsoon/features/interests/presentation/pages/choose_interests_screen.dart';
import 'package:azsoon/features/join_space/bloc/join_space_bloc.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/profile/presentation/screens/profile_screen.dart';
import 'package:azsoon/features/space/bloc/load_post_bloc.dart';
import 'package:azsoon/features/space/presentation/post_screen.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../features/profile/bloc/profile_bloc.dart';
import '../features/space/bloc/space_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    JoinSpaceBloc joinSpaceBloc = JoinSpaceBloc();
    switch (settings.name) {
      case LoadingScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoadingBlocBloc(),
                  child: const LoadingScreen(),
                ));
      case HomeScreenPage.routeName:
        return PageAnimationTransition(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeScreenBloc(),
              ),
              BlocProvider.value(
                value: joinSpaceBloc,
              ),
            ],
            child: const HomeScreenPage(),
          ),
          pageAnimationType: BottomToTopTransition(),
        );

      case SpaceScreen.routeName:
        int spaceId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SpaceBloc(),
                  child: SpaceScreen(
                    id: spaceId,
                  ),
                ));
      case ProfileScreen.routeName:
        bool? isNav = settings.arguments as bool?;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileBloc(),
                  child: ProfileScreen(
                    isNav: isNav,
                  ),
                ));
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case ChooseInterestsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChooseInterestsScreen());
      case '/chooseInterests':
        return MaterialPageRoute(builder: (_) => Container());

      case PostScreen.routeName:
        int postId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoadPostBloc(),
                  child: PostScreen(
                    postId: postId,
                  ),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
