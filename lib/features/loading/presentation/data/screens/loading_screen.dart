import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/Auth/presentaiton/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/local_storage.dart';
import '../../../../../Core/notifications/fcm_provider.dart';
import '../../../../../Core/notifications/notifications_service.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FCMProvider.
    });

    context.read<ProfileBloc>().add(const LoadMyProfile());
  }

  @override
  Widget build(BuildContext context) {
    FCMProvider.setContext(context);

    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          // Navigator.of(context)
          if (state is ProfileLoaded &&
              state.profileModel.user!.isSuspend == false) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreenPage.routeName, (route) => false);
          } else if (state is ProfileLoaded &&
              state.profileModel.user!.isSuspend == true) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                      body: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<ProfileBloc>()
                                .add(const LoadMyProfile());
                          },
                          child: ListView(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/11.png',
                                      height: 200,
                                      // height: 3000,
                                    ),
                                    const Center(
                                      child: Text(
                                          'Your account has been suspended',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                      child: Text(
                                          'Please contact the admin for more information',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: primaryColor)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async {
                                            await LocalStorage
                                                .removeAuthToken();
                                            if (context.mounted) {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      IntroductionAnimationScreen
                                                          .routeName);
                                            }
                                            // context.read<ProfileBloc>().add(const SignOut());
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Text('Sign Out',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )));
          } else if (state is ProfileLoaded &&
              state.profileModel.user!.isSuspend == true) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreenPage.routeName, (route) => false);
          } else if (state is ProfileIsNotSignedIn) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                IntroductionAnimationScreen.routeName, (route) => false);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              context.read<ProfileBloc>().add(const LoadMyProfile());
              return const Center(
                child: LoadingWidget(),
              );
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
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
