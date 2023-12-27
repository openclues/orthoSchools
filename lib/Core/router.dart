import 'package:azsoon/Auth/bussiness_logi/cubit/auth_cubit_cubit.dart';
import 'package:azsoon/Auth/presentaiton/screens/SignIn.dart';
import 'package:azsoon/Auth/presentaiton/screens/SignUp.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/Auth/presentaiton/screens/reset_Password.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:azsoon/features/interests/presentation/pages/choose_interests_screen.dart';
import 'package:azsoon/features/join_space/bloc/join_space_bloc.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/profile/presentation/screens/profile_screen.dart';
import 'package:azsoon/features/space/bloc/cubit/verify_email_cubit.dart';
import 'package:azsoon/features/space/bloc/load_post_bloc.dart';
import 'package:azsoon/features/space/bloc/my_spaces_bloc.dart';
import 'package:azsoon/features/space/presentation/post_screen.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:azsoon/features/verification/persentation/screens/verification_pro_request_screen.dart';
import 'package:azsoon/introduction_animation/introduction_animation_screen.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:azsoon/widgets/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../features/blog/presentation/screens/blog_post_screen.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/space/bloc/space_bloc.dart';
import '../features/verification/bloc/verification_bloc.dart';
import '../features/blog/presentation/screens/blog.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/space/bloc/space_bloc.dart';
import '../screens/NewProfile_page.dart';
import 'page_router_animation.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    JoinSpaceBloc joinSpaceBloc = JoinSpaceBloc();
    switch (settings.name) {
      case LoadingScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
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
      case IntroductionAnimationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const IntroductionAnimationScreen());
      case My_Account_Settings.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => VerifyEmailCubit(),
                  child: My_Account_Settings(),
                ));
      case ResetPassword.routeName:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case SecondStep.routeName:
        return MaterialPageRoute(builder: (_) => const SecondStep());
      case ThirdStep.routeName:
        return MaterialPageRoute(builder: (_) => const ThirdStep());
      case SettingsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case ProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case NewProfile_Page.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileBloc(),
                  child: NewProfile_Page(),
                ));
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
        var arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => ProfileBloc(),
                    ),
                    BlocProvider(
                      create: (context) => MySpacesBloc(),
                    ),
                    BlocProvider(
                      create: (context) => JoinSpaceBloc(),
                    ),
                  ],
                  child: ProfilePage(
                    userId: arguments['userId'],
                    isNav: arguments['isNav'] ?? false,
                  ),
                ));

      case VerificationProRequestScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => VerificationBloc(),
                  child: const VerificationProRequestScreen(),
                ));
      // case ProfileScreen.routeName:
      //   bool? isNav = settings.arguments as bool?;
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => ProfileBloc(),
      //             child: ProfileScreen(
      //               isNav: isNav,
      //             ),
      //           ));
      case SignInScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubitCubit(),
                  child: const SignInScreen(),
                ));
      case SignUpScreen.routeName:
        return CustomSlidePageRoute(
            page: BlocProvider(
          create: (context) => AuthCubitCubit(),
          child: const SignUpScreen(),
        ));
      case BlogScreen.routeName:
        return MaterialPageRoute(builder: (_) => BlogScreen());
      case ChooseInterestsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChooseInterestsScreen());
      case '/chooseInterests':
        return MaterialPageRoute(builder: (_) => Container());

      case PostScreen.routeName:
        LatestUpdatedPost post = settings.arguments as LatestUpdatedPost;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoadPostBloc(),
                  child: PostScreen(
                    post: post,
                  ),
                ));

      case BlogPostScreen.routeName:
        PostModel? blogPostModel = settings.arguments as PostModel?;
        return MaterialPageRoute(
            builder: (_) => BlogPostScreen(
                  blogPostModel: blogPostModel,
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
