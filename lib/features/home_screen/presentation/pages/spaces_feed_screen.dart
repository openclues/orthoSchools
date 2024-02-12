import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../Core/colors.dart';
import '../../../../common_widgets/Post.dart';
import '../../../space/join_space/bloc/join_space_bloc.dart';
import '../../bloc/home_screen_bloc.dart';
import '../widgets/home_screen_header.dart';
import '../widgets/spacesWidget.dart';

class SpacesFeedScreen extends StatelessWidget {
  const SpacesFeedScreen({
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
            Fluttertoast.showToast(
                msg: 'Joined successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: primaryColor,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is JoinSpaceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        },
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            HomeScreenState state = context.read<HomeScreenBloc>().state;
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              if (state is HomeScreenLoaded) {
                if (state.posts.next != null) {
                  context.read<HomeScreenBloc>().add(LoadMorePosts(
                      nextUrl: state.posts.next, homeLoaded: state));
                }
              }
            }
            return true;
          },
          child: ListView(
            children: const [
              HomeScreenHeader(),
              SpacesList(),
              PostWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
