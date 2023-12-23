import 'package:azsoon/Auth/presentaiton/screens/SignIn.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/blog/presentation/screens/blog.dart';
import 'package:azsoon/features/interests/presentation/pages/choose_interests_screen.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home_screen/presentation/pages/home_screen.dart';

class LoadingScreen extends StatelessWidget {
  static const String routeName = '/';
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoadingBlocBloc, LoadingBlocState>(
        listener: (context, state) async {
          Navigator.of(context)
              .pushNamed(HomeScreenPage.routeName); //TODO REMOVE THIS
          // if (state is UserIsSignedIn) {
          //   Navigator.of(context).pushNamed(HomeScreenPage.routeName);
          // }

          // if (state is UserIsNotSignedIn) {
          //   Navigator.of(context).pushNamed(SignInScreen.routeName);
          // }
        },
        child: BlocBuilder<LoadingBlocBloc, LoadingBlocState>(
          builder: (context, state) {
            if (state is LoadingBlocInitial) {
              BlocProvider.of<LoadingBlocBloc>(context)
                  .add(const CheckUserStatus());
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is UserIsNotSignedIn) {}
            return const Center(
              child: LoadingWidget(),
            );
          },
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
