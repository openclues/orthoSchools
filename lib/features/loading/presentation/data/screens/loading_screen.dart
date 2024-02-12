import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/Auth/presentaiton/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home_screen/presentation/pages/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String routeName = '/';
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<LoadingBlocBloc>().add(const CheckUserStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          // Navigator.of(context)
          if (state is ProfileLoaded) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreenPage.routeName, (route) => false);
          }

          if (state is ProfileIsNotSignedIn) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                IntroductionAnimationScreen.routeName, (route) => false);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              context.read<ProfileBloc>().add(const LoadMyProfile());
              print('ProfileInitial');
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
