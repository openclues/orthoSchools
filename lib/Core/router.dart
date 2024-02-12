import 'package:azsoon/features/blog/bloc/cubit/blog_cupit_cubit.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:azsoon/features/interests/presentation/pages/choose_interests_screen.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:azsoon/features/profile/cubit/user_profile_cubit_cubit.dart';
import 'package:azsoon/features/space/bloc/add_post_bloc.dart';
import 'package:azsoon/features/space/bloc/cubit/load_posts_cubit.dart';
import 'package:azsoon/features/space/bloc/cubit/space_post_comments_cubit.dart';
import 'package:azsoon/features/space/bloc/cubit/verify_email_cubit.dart';
import 'package:azsoon/features/space/presentation/post_screen.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:azsoon/features/verification/persentation/screens/verification_pro_request_screen.dart';
import 'package:azsoon/features/Auth/presentaiton/introduction_animation/introduction_animation_screen.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:azsoon/common_widgets/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../features/Auth/bussiness_logi/cubit/auth_cubit_cubit.dart';
import '../features/Auth/presentaiton/screens/SignIn.dart';
import '../features/Auth/presentaiton/screens/SignUp.dart';
import '../features/Auth/presentaiton/screens/reset_Password.dart';
import '../features/become_premium/presentation/be_premium_screen.dart';
import '../features/blog/data/models/articles_model.dart';
import '../features/blog/presentation/screens/blog_post_screen.dart';
import '../features/home_screen/data/models/recommended_spaces_model.dart';
import '../features/notifications/cubit/notifications_cubit.dart';
import '../features/notifications/persentation/notifications_screen.dart';
import '../features/space/bloc/space_bloc.dart';
import '../features/space/join_space/bloc/join_space_bloc.dart';
import '../features/verification/bloc/verification_bloc.dart';
import '../features/blog/presentation/screens/blog_screen.dart';
import '../screens/NewProfile_page.dart';
import 'page_router_animation.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    JoinSpaceBloc joinSpaceBloc = JoinSpaceBloc();
    // HomeScreenBloc homeScreenBloc = HomeScreenBloc();
    switch (settings.name) {
      case LoadingScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case HomeScreenPage.routeName:
        return PageAnimationTransition(
          page: MultiBlocProvider(
            providers: [
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
                  child: const My_Account_Settings(),
                ));
      case ResetPassword.routeName:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case SecondStep.routeName:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String email = arguments['email'] as String;
        return MaterialPageRoute(
            builder: (_) => SecondStep(
                  email: email,
                ));
      case ThirdStep.routeName:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String email = arguments['email'] as String;
        String code = arguments['code'] as String;
        return MaterialPageRoute(
            builder: (_) => ThirdStep(
                  code: code,
                  email: email,
                ));
      case SettingsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case ProfilePage.routeName:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => UserProfileCubitCubit(),
                  child: ProfilePage(
                    isNav: arguments['isNav'],
                    userId: arguments['userId'],
                  ),
                ));
      case NewProfile_Page.routeName:
        return MaterialPageRoute(builder: (_) => const NewProfile_Page());
      case PartnerForm.routeName:
        return MaterialPageRoute(builder: (_) => const PartnerForm());
      case SpaceScreen.routeName:
        // int spaceId = settings.arguments as int;
        RecommendedSpace spaceId = settings.arguments as RecommendedSpace;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SpaceBloc(),
                    ),
                    BlocProvider(
                      create: (context) => LoadPostsCubit(),
                    ),
                    BlocProvider(
                      create: (context) => AddPostBloc(),
                    ),
                  ],
                  child: SpaceScreen(
                    id: spaceId.id!,
                    space: spaceId,
                  ),
                ));
      // case ProfileScreen.routeName:
      //   var arguments = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => MultiBlocProvider(
      //             providers: [
      //               // BlocProvider(
      //               //   create: (context) => ProfileBloc(),
      //               // ),
      //               BlocProvider(
      //                 create: (context) => MySpacesBloc(),
      //               ),
      //               BlocProvider(
      //                 create: (context) => JoinSpaceBloc(),
      //               ),
      //             ],
      //             child: ProfilePage(
      //               userId: arguments['userId'],
      //               isNav: arguments['isNav'] ?? false,
      //             ),
      //           ));

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
        BlogsModel blog = settings.arguments as BlogsModel;
        // bool isFollowed = arguments['isFollowed'] as bool;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => BlogCupitCubit(),
                  child: BlogScreen(
                    blog: blog,
                  ),
                ));
      case ChooseInterestsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChooseInterestsScreen());
      case '/chooseInterests':
        return MaterialPageRoute(builder: (_) => Container());

      case PostScreen.routeName:
        LatestUpdatedPost post = settings.arguments as LatestUpdatedPost;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => LoadPostsCubit(),
                    ),
                  ],
                  child: PostScreen(
                    post: post,
                  ),
                ));
      // case CommentsScreen.routeName:
      //   int postId = settings.arguments as int;
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => SpacePostCommentsCubit(),
      //             child: CommentsScreen(

      //               showRepy: false,
      //               onTap: (v) {},
      //               postId: postId,
      //             ),
      //           ));
      case BlogPostScreen.routeName:
        PostModel? blogPostModel = settings.arguments as PostModel?;
        return MaterialPageRoute(
            builder: (_) => BlogPostScreen(
                  blogPostModel: blogPostModel,
                ));
      //  case BlogScreen.routeName:
      //   BlogModel blog = settings.arguments as BlogModel;
      //   return MaterialPageRoute(
      //       builder: (_) => const BlogScreen(
      //           ));

      case NotificationsScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => NotificationsCubit(),
                  child: const NotificationsScreen(),
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
