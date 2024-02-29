import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/blog/bloc/articles_feed_bloc.dart';
import 'package:azsoon/features/blog/bloc/cubit/articales_cubit_cubit.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home_screen/presentation/discover_screen.dart';
import '../../../home_screen/presentation/widgets/home_screen_header.dart';
import '../../../home_screen/presentation/widgets/search_filter_wigdet.dart';
import '../../../profile/presentation/screens/create_blog_screen.dart';

class ArticlesFeedScreen extends StatefulWidget {
  const ArticlesFeedScreen({super.key});

  @override
  State<ArticlesFeedScreen> createState() => _ArticlesFeedScreenState();
}

class _ArticlesFeedScreenState extends State<ArticlesFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      body: BlocBuilder<ArticlesFeedBloc, ArticlesFeedState>(
        builder: (context, state) {
          if (state is ArticlesFeedInitial) {
            context.read<ArticlesFeedBloc>().add(const FetchArticlesFeed());
          } else if (state is ArticlesFeedError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ArticlesFeedLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Profile profile =
                (context.read<ProfileBloc>().state as ProfileLoaded)
                    .profileModel;

            return ListView(
              children: [
                const SizedBox(
                  height: 16,
                ),
                if (profile.user!.isVerifiedPro == true && profile.blog == null)
                  const CreateYourBlogIncourgement(),
                const SearchAndFilterWidget(),
                const RecommendedBlogsWidget(),
                const SizedBox(
                  height: 50,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CreateYourBlogIncourgement extends StatelessWidget {
  const CreateYourBlogIncourgement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/quality.png', height: 25),
                      const Text(
                        " You are a verified pro user",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Create your blog and start sharing your knowledge with the world",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BlogCreationScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Create Your Blog",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class RecommendedBlogsWidget extends StatelessWidget {
  const RecommendedBlogsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesFeedBloc, ArticlesFeedState>(
      builder: (context, state) {
        if (state is ArticlesFeedLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.recommendedBlogs.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Recommended Blogs",
                        style: TextStyle(fontSize: 15, color: primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.recommendedBlogs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BlogDiscoveryItem(
                              blog: state.recommendedBlogs[index]);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Latest Articles",
                  style: TextStyle(fontSize: 15, color: primaryColor),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.recommendedArticles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ArticaleWidget(
                      articlesModel: state.recommendedArticles[index]);
                },
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
