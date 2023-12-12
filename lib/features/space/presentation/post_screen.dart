import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/bloc/load_post_bloc.dart';
import 'package:azsoon/widgets/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  static const routeName = '/post';
  final int postId;
  const PostScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<LoadPostBloc, LoadPostState>(
          builder: (context, state) {
            if (state is LoadPostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadPostLoaded) {
              return PostLoadedWidget(
                post: state.post,
              );
            }
            if (state is LoadPostInitial) {
              context
                  .read<LoadPostBloc>()
                  .add(LoadPost(postId: postId.toString()));
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}

class PostLoadedWidget extends StatelessWidget {
  final LatestUpdatedPost post;
  const PostLoadedWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PostImagesWidhet(post: post),
          Text(post.content!),
        ],
      ),
    );
  }
}
