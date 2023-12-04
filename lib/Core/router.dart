import 'package:azsoon/Auth/SignIn.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:azsoon/features/interests/presentation/pages/choose_interests_screen.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoadingScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoadingBlocBloc(),
                  child: const LoadingScreen(),
                ));
      case HomeScreenPage.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreenPage());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => Container());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case ChooseInterestsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChooseInterestsScreen());
      case '/chooseInterests':
        return MaterialPageRoute(builder: (_) => Container());
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
