
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
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create Post',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            onTap: () async {
                              await Navigator.of(context).push(
                                  PageAnimationTransition(
                                      pageAnimationType:
                                          BottomToTopTransition(),
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
                              context
                                  .read<HomeScreenBloc>()
                                  .add(const LoadHomeScreenData());
                            },
                            leading: const Icon(
                              IconlyLight.home,
                              color: primaryColor,
                            ),
                            title: const Text('In a Space'),
                            subtitle: const Text(
                                'Post in a space you are a member of'),
                          ),
                          Builder(builder: (context) {
                            return ListTile(
                              onTap: () {
                                //show another modal to tell user that he is not verified yet so he can not post on a blog. and ask him verify his account first

                                showBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return SizedBox(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            const Text(
                                                'You are not verified yet'),
                                            const Text(
                                                'Please verify your account first'),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text('Verify'))
                                          ],
                                        ),
                                      );
                                    });

                                // Navigator.pop(context);
                                // Navigator.pushNamed(
                                //     context, SpaceScreen.routeName,
                                //     arguments: 2);
                              },
                              leading: const Icon(
                                IconlyLight.home,
                                color: primaryColor,
                              ),
                              title: const Text('In a Blog'),
                              subtitle: const Text('Post in your blog'),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              IconlyBold.plus,
              // opticalSize: 1.5,
              semanticLabel: 'Add',
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

