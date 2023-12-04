import 'package:azsoon/Auth/SignIn.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/interests/presentation/pages/choose_interests_screen.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  static const String routeName = '/';
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoadingBlocBloc, LoadingBlocState>(
        listener: (context, state) async {
          // if (state is UserIsSignedIn) {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: SuccessSnackbar(),
          //   ));
          //   Navigator.pushNamed(context, HomeScreenPage.routeName);
          if (state is UserIsNotSignedIn) {
            await Future.delayed(const Duration(seconds: 2));

            Navigator.pushNamed(context, ChooseInterestsScreen.routeName);
          }
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