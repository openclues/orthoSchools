import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../../Core/colors.dart';
import '../../../space/bloc/add_post_bloc.dart';
import '../../../space/bloc/my_spaces_bloc.dart';
import '../../../space/presentation/add_post.dart';
import '../../bloc/home_screen_bloc.dart';

class AddSpacePostBlogButton extends StatelessWidget {
  const AddSpacePostBlogButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bodyColor,
      margin: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            splashColor: Colors.white,
            backgroundColor: primaryColor,
            onPressed: () async {
              await Navigator.of(context).push(PageAnimationTransition(
                  pageAnimationType: BottomToTopTransition(),
                  page: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => MySpacesBloc(),
                      ),
                      BlocProvider(
                        create: (context) => AddPostBloc(),
                      ),
                    ],
                    child: const AddPostScreen(),
                  )));
            },
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                return state is HomeScreenLoaded && state.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(
                        IconlyBold.plus,
                        // opticalSize: 1.5,
                        semanticLabel: 'Add',
                        size: 30,
                        color: Colors.white,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
