import 'dart:convert';

import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Core/colors.dart';
import '../../../common_widgets/Button.dart';
import '../../blog/presentation/screens/articles_feed.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/presentation/screens/create_blog_screen.dart';

class PremiumZone extends StatelessWidget {
  const PremiumZone({super.key});

  loadCourses() async {
    var response = await RequestHelper.get('courses/');

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        body: ListView(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Premium Zone",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  // return Text(state.profileModel.firstName);
                  if (state.profileModel.blog != null) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          BlogScreen.routeName,
                          arguments: state.profileModel.blog,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Manage your blog ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 80,
                              width: double.infinity,
                              //show blog details

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(!state
                                          .profileModel.blog!.cover!
                                          .contains('http')
                                      ? ApiEndpoints.baseUrl +
                                          state.profileModel.blog!.cover!
                                      : state.profileModel.blog!.cover!),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.darken),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.profileModel.blog!.title!,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const CreateYourBlogIncourgement();
                  }
                } else {
                  return const Text('Loading');
                }
                return Text(state.toString());
              },
            ),
            FutureBuilder(
              future: loadCourses(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<CourseModel> courses = [];
                  for (var course in snapshot.data) {
                    courses.add(CourseModel.fromJson(course));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Premium Courses',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: CourseDetailsWidget(
                              title: courses[index].courseName!,
                              coverImage: courses[index].courseCover!,
                              description: courses[index].courseDescription!,
                              onJoinPressed: () async {
                                try {
                                  launchUrl(
                                      Uri.parse(courses[index].courseLink!));
                                } catch (e) {
                                  print(e);
                                }

                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (_) => BlocProvider.value(
                                //       value: context.read<ProfileBloc>(),
                                //       child: BlogCreationScreen(),
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}

class CourseModel {
  final int id;
  final String? courseName;
  final String? courseDescription;
  final String? courseCover;
  final String? courseImage;
  final String? courseVideo;
  final String? courseLink;

  CourseModel({
    required this.id,
    required this.courseName,
    required this.courseDescription,
    required this.courseCover,
    required this.courseImage,
    required this.courseVideo,
    required this.courseLink,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      courseName: json['course_name'] ?? "",
      courseDescription: json['course_description'] ?? "",
      courseCover: json['course_cover'] ?? "",
      courseImage: json['course_image'] ?? "",
      courseVideo: json['course_video'] ?? "",
      courseLink: json['course_link'] ?? "",
    );
  }
}

// [{"id":1,"course_name":"zxczxc","course_description":"zxczxczxczxczx","course_cover":null,"course_image":null,"course_video":null,"course_link":"https://www.flaticon.com/search?word=Clinical%20Dentistry"},{"id":2,"course_name":"dsfsdf","course_description":"sdfsdfsdffsd","course_cover":null,"course_image":null,"course_video":null,"course_link":"https://www.flaticon.com/search?word=Clinical%20Dentistry"}]

class CourseDetailsWidget extends StatelessWidget {
  final String title;
  final String coverImage;
  final String description;
  final VoidCallback onJoinPressed;

  const CourseDetailsWidget({
    super.key,
    required this.title,
    required this.coverImage,
    required this.description,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      // height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        // elevation: 5,
        // margin: EdgeInsets.all(10),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(ApiEndpoints.baseUrl + coverImage),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          buttonText: 'Join',
                          buttonColor: const Color(0XFFF4F4F4),
                          borderColor: const Color(0XFFF4F4F4),
                          textColor: primaryColor,
                          height: 43,
                          onpress: onJoinPressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
